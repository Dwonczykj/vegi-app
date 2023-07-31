import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart' as mime;
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

enum AuthenticationStatus {
  unauthenticated,
  authenticationFailed,
  authenticationSucceeded,
  expired,
}

abstract class HttpService {
  final Dio dio;
  String get baseUrl => this.dio.options.baseUrl;
  AuthenticationStatus authStatus = AuthenticationStatus.unauthenticated;

  HttpService(this.dio, String baseUrl) {
    this.dio.options.baseUrl = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    this.dio.options.headers = Map.from({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
  }

  bool _checkAuthRequestIsSatisfied(
    bool authRequired, {
    required bool dontRoute,
  }) {
    final unsatisfied =
        authRequired && !this.dio.options.headers.containsKey('Cookie');
    if (unsatisfied &&
        !dontRoute &&
        authStatus != AuthenticationStatus.authenticationFailed) {
      if (rootRouter.current.name != SignUpScreen.name) {
        log.info(
          'Push SignUpScreen() as authRequired for vegi but not logged in.',
          stackTrace: StackTrace.current,
        );
        rootRouter.push(const SignUpScreen());
      }
    }
    return !unsatisfied;
  }

  bool get hasCookieStored => dio.options.headers.containsKey('Cookie');

  Future<void> deleteSessionCookie() async {
    if (hasCookieStored) {
      dio.options.headers.remove('Cookie');
    }
    authStatus = AuthenticationStatus.expired;
  }

  Future<bool> isCookieExpired() async {
    bool cookieHasExpired = true;
    if (hasCookieStored) {
      final cookie = dio.options.headers['Cookie'] as String;
      final expiryStrPattern =
          RegExp('Expires=([A-Za-z]{3}, [0-9]{1,2} [A-Za-z]{3} [0-9]{4})');
      final x = expiryStrPattern.firstMatch(cookie);
      if (x != null) {
        final dtStr = x[0];
      }
      cookieHasExpired = true;
    } else {
      cookieHasExpired = true;
    }
    if (cookieHasExpired) {
      authStatus = AuthenticationStatus.expired;
      log.info(
        'vegi session has expired',
        stackTrace: StackTrace.current,
      );
      (await reduxStore).dispatch(
        SetUserAuthenticationStatus(
          vegiStatus: VegiAuthenticationStatus.unauthenticated,
        ),
      );
    }
    return cookieHasExpired;
  }

  Future<void> logoutSession() async {
    if (hasCookieStored) {
      dio.options.headers.remove('Cookie');
    }
    authStatus = AuthenticationStatus.unauthenticated;
    (await reduxStore).dispatch(SetVerificationFailed());
  }

  Future<void> setSessionCookie(String cookie) async {
    dio.options.headers['Cookie'] = cookie;
    authStatus = AuthenticationStatus.authenticationSucceeded;
  }

  bool _checkAuthDioResponse(
    DioError dioErr, {
    required bool dontRoute,
  }) {
    if (dioErr.response?.statusCode == 401) {
      // TODO? Do we need to set: set state logged out to true and then route to the login signin buttons screen
      // navigating to the splash screen should ensure user can login back into vegi again using the phone -sms firebase onboard
      deleteSessionCookie();
      // log.info('Push SignUpScreen()');
      // rootRouter.push(const SignUpScreen());
      return true;
    }
    return false;
  }

  Future<Response<T>> _logHttpResult<T>(
    Future<Response<T>> responseAwaiter, {
    bool dontLog = false,
  }) {
    return responseAwaiter.then(
      (response) {
        if (dontLog) {
          return response;
        }
        final cookiePresentStr =
            response.headers.value('Set-Cookie') != null ? '🍪' : '';
        String data = '';
        if (response.requestOptions.method == 'POST') {
          data = jsonEncode(response.requestOptions.data);
        } else if (response.requestOptions.method == 'GET') {
          data = jsonEncode(response.requestOptions.queryParameters);
        }
        log.info(
          '${response.requestOptions.method}: "${response.requestOptions.uri}" -> [${response.statusCode}]$cookiePresentStr \n params:"$data"',
        );
        return response;
      },
    );
  }

  Future<Response<T>> _handleHttpResult<T>(
    Future<Response<T>> Function() responseAwaiterCallback, {
    required String httpProtocol,
    T? errorResponseData,
    bool dontRoute = false,
    List<int> allowStatusCodes = const <int>[],
    Pattern? allowErrorMessage,
  }) async {
    try {
      return responseAwaiterCallback();
    } on DioError catch (error, stackTrace) {
      if (error.response != null &&
          (allowStatusCodes.contains(error.response?.statusCode) ||
              (allowErrorMessage != null &&
                  '${error.response?.data}'.contains(allowErrorMessage)))) {
        return Response(
          data: null,
          extra: (error.response?.extra ?? {})
            ..addAll(
              {
                'message':
                    '$httpProtocol: "error.response?.realUri" expected response with code: [${error.response!.statusCode}]',
                'errorMessage': error.response?.data,
                'stackTrace': stackTrace.filterCallStack().pretty(),
              },
            ),
          statusCode: 200,
          requestOptions: RequestOptions(path: 'error.response?.realUri'),
        );
      }
      if (error.toString().contains('Connection reset by peer') ||
          error.response?.data.toString() == 'Unauthorized') {
        await deleteSessionCookie(); //todo: return a 401...
        // rootRouter.push(const SignUpScreen());
        log
          ..error(
              'Ran into error trying to $httpProtocol to "error.response?.realUri"')
          ..error(
            error,
            stackTrace: stackTrace,
          );
        return Response(
          data: errorResponseData,
          extra: {
            'error': error,
            'message': 'Stale session cookie possible caused by server reboot',
            'stackTrace': stackTrace.filterCallStack().pretty(),
          },
          statusCode: 401,
          requestOptions: RequestOptions(path: 'error.response?.realUri'),
        );
      }
      log
        ..error(
            'Ran into error trying to $httpProtocol to "error.response?.realUri"')
        ..error(error, stackTrace: stackTrace);
      if (error.response?.statusCode == 403 ||
          error.response?.statusCode == 401) {
        await peeplEatsService.isLoggedIn();
      }
      log.warn(
          'Got an error $httpProtocol response from "${error.response?.realUri}" with error: "${error.response?.data}"');

      if (!_checkAuthDioResponse(error, dontRoute: dontRoute)) {
        return Response(
          data: errorResponseData,
          extra: {
            'error': error.error,
            'message': error.message,
            'errorMessage': error.response?.data,
            'dioResponse': error.response,
            'dioErrorType': error.type,
            'data': error.response?.data,
            'stackTrace': stackTrace.filterCallStack().pretty(),
          },
          isRedirect: error.response?.isRedirect ?? false,
          redirects: error.response?.redirects ?? [],
          headers: error.response?.headers,
          statusCode: error.response?.statusCode ?? 500,
          requestOptions: error.requestOptions,
        );
      } else {
        return Future.value(
          Response(
            data: errorResponseData,
            extra: {
              'error': null,
              'message':
                  'Stale session cookie possible caused by server reboot',
              'errorMessage': error.response?.data,
              'stackTrace': stackTrace.filterCallStack().pretty(),
            },
            statusCode: 401,
            requestOptions: RequestOptions(path: 'error.response?.realUri'),
          ),
        );
      }
    } on Exception catch (error, stackTrace) {
      log.error(
        error,
        stackTrace: stackTrace,
      );
      return Response(
        data: errorResponseData,
        extra: {
          'error': null,
          'message': 'Stale session cookie possible caused by server reboot',
          'stackTrace': stackTrace.filterCallStack().pretty(),
        },
        statusCode: 400,
        requestOptions:
            RequestOptions(path: '${dio.options.baseUrl}/unknown...'),
      );
    } catch (error, stackTrace) {
      if (error.toString().contains('Connection reset by peer') ||
          error.toString().contains('Unauthorized')) {
        await deleteSessionCookie(); //todo: return a 401...
        // rootRouter.push(const SignUpScreen());
        log
          ..error(
              'Ran into error trying to $httpProtocol to "error.response?.realUri"')
          ..error(error, stackTrace: stackTrace);
        return Response(
          data: errorResponseData,
          extra: {
            'error': null,
            'message': 'Stale session cookie possible caused by server reboot',
            'stackTrace': stackTrace.filterCallStack().pretty(),
          },
          statusCode: 401,
          requestOptions: RequestOptions(path: 'error.response?.realUri'),
        );
      }
      if (error is Map<String, dynamic> &&
          error['message'].toString().startsWith('SocketException:') &&
          dio.options.baseUrl.startsWith('http://localhost')) {
        log
          ..error(
              'Ran into error trying to $httpProtocol to "error.response?.realUri"')
          ..error(error, stackTrace: stackTrace)
          ..warn(
            'If running from real_device, cant connect to localhost on running machine...',
          );
      }
      return Response(
        data: errorResponseData,
        extra: {
          'error': error,
          'message': '$error',
          'stackTrace': stackTrace.filterCallStack().pretty(),
        },
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      );
    }
  }

  Future<Response<T?>> dioGet<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    bool dontRoute = false,
    bool sendWithAuthCreds = false,
    List<int> allowStatusCodes = const <int>[],
    Map<String, String>? customHeaders,
    bool dontLog = false,
  }) async {
    _checkAuthRequestIsSatisfied(sendWithAuthCreds, dontRoute: dontRoute);
    if (!path.startsWith('/')) path = '/' + path;
    const protocol = 'GET';
    log.info(
      '$protocol: "${dio.options.baseUrl}$path"',
      sentry: true,
    );
    if (customHeaders?.isNotEmpty ?? false) {
      options ??= Options();
      options.headers?.addAll(customHeaders!);
    }
    return _handleHttpResult(
      () => _logHttpResult(
        dio.get<T>(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        ),
        dontLog: dontLog,
      ),
      httpProtocol: protocol,
    );
    // try {
    // } on DioError catch (dioErr, stackTrace) {
    //   log.warn(
    //       'Got an error GET response from "${dioErr.response?.realUri}" with error: "${dioErr.response?.data}"');
    //   if (dioErr.response != null &&
    //       allowStatusCodes.contains(dioErr.response!.statusCode)) {
    //     return Future.value(
    //       Response(
    //         data: null,
    //         extra: {
    //           'message':
    //               '$protocol: "${dio.options.baseUrl}$path" returned expected error response with code: [${dioErr.response!.statusCode}]',
    //           'errorMessage': dioErr.response?.data,
    //           'stackTrace': stackTrace.filterCallStack().pretty(),
    //         },
    //         statusCode: 200,
    //         requestOptions: RequestOptions(path: '${dio.options.baseUrl}$path'),
    //       ),
    //     );
    //   }
    //   if (!_checkAuthDioResponse(dioErr, dontRoute: dontRoute)) {
    //     log.error(
    //         'ERROR [vegi service [${dioErr.response?.statusCode}]] - dioGet -> $dioErr');
    //   }
    //   return Future.value(
    //     Response(
    //       data: null,
    //       extra: {
    //         'error': dioErr,
    //         'message':
    //             '$protocol: "${dio.options.baseUrl}$path" threw -> "${dioErr.message}"',
    //         'errorMessage': dioErr.response?.data,
    //       },
    //       statusCode: dioErr.response?.statusCode,
    //       requestOptions: RequestOptions(path: '${dio.options.baseUrl}$path'),
    //     ),
    //   );
    // } catch (e, s) {
    //   log.error(
    //     'ERROR - dio$protocol -> $e',
    //     stackTrace: s,
    //   );
    //   return Future.value(
    //     Response(
    //       data: null,
    //       extra: {
    //         'error': e,
    //         'message': '$protocol: "${dio.options.baseUrl}$path" threw -> "$e"',
    //       },
    //       requestOptions: RequestOptions(path: '${dio.options.baseUrl}$path'),
    //     ),
    //   );
    // }
  }

  Future<Response<T>> dioPost<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T? errorResponseData,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool dontRoute = false,
    bool sendWithAuthCreds = false,
    List<int> allowStatusCodes = const <int>[],
    Pattern? allowErrorMessage,
    Map<String, String>? customHeaders,
    bool dontLog = false,
  }) async {
    const protocol = 'POST';
    var path_ = path;
    if (!path.startsWith('/') && !dio.options.baseUrl.endsWith('/')) {
      path_ = '/$path';
    } else if (path.startsWith('/') && dio.options.baseUrl.endsWith('/')) {
      path_ = path.substring(1);
    }
    if (dontLog == false) {
      log.info(
        '$protocol: "${dio.options.baseUrl}$path_"',
        sentry: true,
      );
    }
    _checkAuthRequestIsSatisfied(sendWithAuthCreds, dontRoute: dontRoute);
    if (customHeaders?.isNotEmpty ?? false) {
      options ??= Options();
      options.headers ??= {};
      options.headers!.addAll(customHeaders!);
    }

    return _handleHttpResult(
      () => _logHttpResult(
        dio.post<T>(
          path_,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
        dontLog: dontLog,
      ),
      httpProtocol: protocol,
    );
  }

  Future<Response<T>> dioPutFile<T>(
    String path, {
    required File file,
    Map<String, dynamic>? queryParameters,
    T? errorResponseData,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool dontRoute = false,
    bool sendWithAuthCreds = false,
  }) async {
    const protocol = 'PUT';
    _checkAuthRequestIsSatisfied(sendWithAuthCreds, dontRoute: dontRoute);
    final image = file.readAsBytesSync();

    final options = Options(
      contentType: mime.lookupMimeType(file.path),
      headers: {
        'Accept': 'application/json',
        'Content-Length': image.length,
        'Connection': 'keep-alive',
        'User-Agent': 'ClinicPlush'
      },
    );
    var path_ = path;
    if (!path.startsWith('/') && !dio.options.baseUrl.endsWith('/')) {
      path_ = '/$path';
    } else if (path.startsWith('/') && dio.options.baseUrl.endsWith('/')) {
      path_ = path.substring(1);
    }
    log.info(
      '$protocol: "${dio.options.baseUrl}$path_"',
      sentry: true,
    );

    return _handleHttpResult(
      () => _logHttpResult(dio.put<T>(
        path_,
        data: Stream.fromIterable(image.map((e) => [e])),
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      )),
      httpProtocol: protocol,
    );
    // try {} on DioError catch (error, stackTrace) {
    //   if (error.response?.data.toString() ==
    //       'Unauthorized') if (!_checkAuthDioResponse(error, dontRoute: dontRoute)) {
    //     return Response(
    //       data: errorResponseData,
    //       extra: {
    //         'error': error.error,
    //         'message': error.message,
    //         'errorMessage': error.response?.data,
    //         'dioResponse': error.response,
    //         'dioErrorType': error.type,
    //         'data': error.response?.data,
    //       },
    //       isRedirect: error.response?.isRedirect ?? false,
    //       redirects: error.response?.redirects ?? [],
    //       headers: error.response?.headers,
    //       statusCode: error.response?.statusCode ?? 500,
    //       requestOptions: error.requestOptions,
    //     );
    //   } else {
    //     return Response(
    //       data: errorResponseData,
    //       extra: {
    //         'error': null,
    //         'message': 'Stale session cookie possible caused by server reboot',
    //         'errorMessage': error.response?.data,
    //       },
    //       statusCode: 401,
    //       requestOptions: RequestOptions(path: '${dio.options.baseUrl}${path}'),
    //     );
    //   }
    // } on Exception catch (error, stackTrace) {
    //   if (error.toString().contains('Connection reset by peer') ||
    //       (error is DioError &&
    //           error.response?.data.toString() == 'Unauthorized')) {
    //     await deleteSessionCookie(); //todo: return a 401...
    //     // rootRouter.push(const SignUpScreen());
    //     log
    //       ..error(
    //           'Ran into error trying to POST to "${dio.options.baseUrl}${path.substring(1)}"')
    //       ..error(error, stackTrace: stackTrace);
    //     return Response(
    //       data: errorResponseData,
    //       extra: {
    //         'error': null,
    //         'message': 'Stale session cookie possible caused by server reboot',
    //         'stackTrace': stackTrace.filterCallStack().pretty(),
    //       },
    //       statusCode: 401,
    //       requestOptions: RequestOptions(path: '${dio.options.baseUrl}${path}'),
    //     );
    //   }
    //   return Response(
    //     data: errorResponseData,
    //     extra: {
    //       'error': error,
    //       'message': '$error',
    //       'stackTrace': stackTrace.filterCallStack().pretty(),
    //     },
    //     statusCode: 500,
    //     requestOptions: RequestOptions(path: ''),
    //   );
    // } catch (error, stackTrace) {
    //   if (error is Map<String, dynamic> &&
    //       error['message'].toString().startsWith('SocketException:') &&
    //       dio.options.baseUrl.startsWith('http://localhost')) {
    //     log.warn(
    //       'If running from real_device, cant connect to localhost on running machine...',
    //     );
    //   }
    //   return Response(
    //     data: errorResponseData,
    //     extra: {
    //       'error': error,
    //       'message': '$error',
    //       'stackTrace': stackTrace.filterCallStack().pretty(),
    //     },
    //     statusCode: 500,
    //     requestOptions: RequestOptions(path: ''),
    //   );
    // }
    // return Response(
    //   data: errorResponseData,
    //   extra: {
    //     'error': null,
    //     'message': '',
    //   },
    //   statusCode: 500,
    //   requestOptions: RequestOptions(path: ''),
    // );
  }

  Future<Response<T>> dioPostFile<T>(
    String path, {
    required File file,
    required FormData Function({required MultipartFile file}) formDataCreator,
    required void Function(String error, FileUploadErrCode errCode) onError,
    Map<String, dynamic>? queryParameters,
    T? errorResponseData,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool dontRoute = false,
    bool sendWithAuthCreds = false,
  }) async {
    const protocol = 'POST';
    _checkAuthRequestIsSatisfied(sendWithAuthCreds, dontRoute: dontRoute);
    final image = file.readAsBytesSync();
    var path_ = path;
    if (!path.startsWith('/') && !dio.options.baseUrl.endsWith('/')) {
      path_ = '/$path';
    } else if (path.startsWith('/') && dio.options.baseUrl.endsWith('/')) {
      path_ = path.substring(1);
    }
    log.info(
      '$protocol: "${dio.options.baseUrl}$path_"',
      sentry: true,
    );
    MultipartFile imgByteStream;
    String mimeType;
    String mimeSubType;
    try {
      final mimeTypeData = mime.lookupMimeType(file.path)?.split('/');

      if (mimeTypeData == null || mimeTypeData.length < 2) {
        const wm = 'Unable to get Mime Encoding of Image upload.';
        // throw Exception(wm);
        onError(
          wm,
          FileUploadErrCode.imageEncodingError,
        );
        return Future.value(
          Response(
            data: errorResponseData,
            statusCode: 500,
            requestOptions: RequestOptions(path: path),
          ),
        );
      }
      mimeType = mimeTypeData[0];
      mimeSubType = mimeTypeData[1];
      imgByteStream = MultipartFile.fromFileSync(
        file.path,
        contentType: MediaType(
          mimeType,
          mimeSubType,
        ),
      );
      if ((imgByteStream.length * 0.00000095367432) > fileUploadVegiMaxSizeMB) {
        final wm =
            'Image upload (${(imgByteStream.length * 0.00000095367432).toStringAsFixed(2)}MB) is too large as > ${fileUploadVegiMaxSizeMB}MB. It will be compressed on the server';
        log.info(wm);
        // onError(
        //   wm,
        //   FileUploadErrCode.imageTooLarge,
        // );
        // return Future.value(
        //   Response(
        //     data: errorResponseData,
        //     statusCode: 500,
        //     requestOptions: RequestOptions(path: path),
        //   ),
        // );
      }
    } catch (err, stack) {
      final wm = 'Unable to encode image for sending to vegi: $err';
      log.error(err, stackTrace: stack);
      onError(
        wm,
        FileUploadErrCode.unknownError,
      );
      return Future.value(
        Response(
          data: errorResponseData,
          statusCode: 500,
          requestOptions: RequestOptions(path: path),
        ),
      );
    }

    final options = Options(
      contentType: mime.lookupMimeType(file.path),
      headers: {
        'Accept': 'application/json',
        'Content-Length': image.length,
        'Connection': 'keep-alive',
        'User-Agent': 'ClinicPlush'
      },
    );

    return _handleHttpResult(
      () => _logHttpResult(dio.post<T>(
        path_,
        data: formDataCreator(file: imgByteStream),
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      )),
      httpProtocol: protocol,
    );
    // ..onError((error, stackTrace) {
    //   log.error(error, stackTrace: stackTrace);
    //   if (error is Map<String, dynamic> &&
    //       error['message'].toString().startsWith('SocketException:') &&
    //       dio.options.baseUrl.startsWith('http://localhost')) {
    //     log.warn(
    //       'If running from real_device, cant connect to localhost on running machine...',
    //     );
    //     onError(
    //       'Simulator specific Error',
    //       FileUploadErrCode.unknownError,
    //     );
    //   } else if (error is DioError) {
    //     if (!_checkAuthDioResponse(error, dontRoute: dontRoute)) {
    //       onError(
    //         error.message ?? '',
    //         FileUploadErrCode.unknownError,
    //       );
    //       return Response(
    //         data: errorResponseData,
    //         extra: {
    //           'error': error.error,
    //           'message': error.message,
    //           'errorMessage': error.response?.data,
    //           'dioResponse': error.response,
    //           'dioErrorType': error.type,
    //           'data': error.response?.data,
    //         },
    //         isRedirect: error.response?.isRedirect ?? false,
    //         redirects: error.response?.redirects ?? [],
    //         headers: error.response?.headers,
    //         statusCode: error.response?.statusCode ?? 500,
    //         requestOptions: error.requestOptions,
    //       );
    //     } else {
    //       return Response(
    //         data: errorResponseData,
    //         extra: {
    //           'error': null,
    //           'message':
    //               'Stale session cookie possible caused by server reboot',
    //           'errorMessage': error.response?.data,
    //         },
    //         statusCode: 401,
    //         requestOptions:
    //             RequestOptions(path: '${dio.options.baseUrl}${path}'),
    //       );
    //     }
    //   }
    //   onError(
    //     'Unknown error!',
    //     FileUploadErrCode.unknownError,
    //   );
    //   return Response(
    //     data: errorResponseData,
    //     extra: {
    //       'error': null,
    //       'message': '',
    //     },
    //     statusCode: 500,
    //     requestOptions: RequestOptions(path: path),
    //   );
    // });
  }
}
