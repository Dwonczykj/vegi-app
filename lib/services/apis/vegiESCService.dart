import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:vegan_liverpool/models/esc/escRateProductResponse.dart';
import 'package:vegan_liverpool/services/abstract_apis/httpService.dart';
import 'package:vegan_liverpool/services/apis/vegiBackendEndpoints.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

@lazySingleton
class VegiESCService extends HttpService {
  VegiESCService(Dio dio) : super(dio, Secrets.VEGI_ESC_BACKEND) {
    dio.options.baseUrl = Secrets.VEGI_ESC_BACKEND;
    dio.options.headers = Map.from({'Content-Type': 'application/json'});
    // reduxStore.then(
    //   (store) {
    //     final cookie = store.state.userState.vegiSessionCookie;
    //     if (cookie != null && cookie.isNotEmpty) {
    //       setSessionCookie(cookie);
    //     }
    //   },
    // );
  }

  bool responseHasErrorStatus(
    Response<dynamic> response, [
    List<int> expectErrCodes = const [],
  ]) {
    if (response.statusCode != null && response.statusCode! >= 400) {
      if (expectErrCodes.isNotEmpty &&
          expectErrCodes.contains(response.statusCode)) {
        // dont log but return true;
        log.verbose(
            'Received expected erroneous response: (status: ${response.statusMessage}) from vegi esc server [${response.requestOptions.uri}]');
        return true;
      }
      if (response.extra.containsKey('message') &&
          response.extra['message'] is String) {
        if (!response.extra['message'].toString().contains('Stale session')) {
          log.warn(
              'Handling erroneous response [${response.requestOptions.uri}] with message: "${response.extra['message']}"');
        }
        return true;
      } else {
        log.error(
          'Received an empty response (status: ${response.statusMessage}) from sails vegi backend [${response.requestOptions.uri}]',
        );
      }
      return true;
    }
    if (response.data is Map && (response.data as Map).isEmpty) {
      log.error(
        'Received an empty response (status: ${response.statusMessage}) from sails vegi backend [${response.requestOptions.uri}]',
      );
      return true;
    }
    return false;
  }

  Future<EscRateProductResponse?> rateProduct({
    required int productId,
  }) async {
    try {
      final Response<dynamic> response = await dioGet(
        VegiESCServiceEndpoints.rateVegiProduct(productId: productId),
      );
      if (responseHasErrorStatus(response)) {
        log.error(response.statusMessage ?? 'Unknown Error');
        return null;
      } else {
        final result =
            EscRateProductResponse.fromJson(response.data as Map<String, dynamic>);
        return result;
      }
    } on Exception catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 404) {
          return null;
        }
      }
      rethrow;
    }
  }
}
