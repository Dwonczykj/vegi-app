import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:redux/redux.dart';
import 'package:responsive_framework/responsive_framework.dart';
// import 'package:screen_capture_event/screen_capture_event.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uni_links/uni_links.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/di/env.dart';
// import 'package:vegan_liverpool/common/di/package_info.dart';
import 'package:vegan_liverpool/common/router/route_guards.dart';
import 'package:vegan_liverpool/common/router/vegi_debug_route_observer.dart';
import 'package:vegan_liverpool/constants/strings.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/dismiss_keyboard.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/app_env_actions.dart';
import 'package:vegan_liverpool/redux/actions/home_page_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

enum UniLinksType { string, uri }

class MyApp extends StatefulWidget {
  const MyApp(this.store, {Key? key}) : super(key: key);
  final Store<AppState> store;

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Locale? _locale;
  Object? _err;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  StreamSubscription? _sub;
  final UniLinksType _type = UniLinksType.string;
  String _latestLink = 'Unknown';
  Uri? _latestUri;
  // final ScreenCaptureEvent screenListener = ScreenCaptureEvent();

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  //Authentication token used for calls with Fuse
  // void setJwtToken(Store<AppState> store) {
  //   final String jwtToken = store.state.userState.jwtToken;
  //   if (![null, ''].contains(jwtToken)) {
  //     isAuthenticatedRouteGuard = true;
  //     log.info('JWT: $jwtToken');
  //     (await fuseWalletSDK).jwtToken = jwtToken;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // setJwtToken(widget.store);
    widget.store
      ..dispatch(fetchHomePageData())
      // ..dispatch(
      //   checkIfSmartWalletIsBackedUpToVegi(
      //     errorHandler: (message, errcode) => inDebugMode
      //         ? showErrorSnack(
      //             context: context,
      //             title: Messages.walletSignedOutSnackbarMessage,
      //             message: 'Error checking for smart wallet backup: $message',
      //           )
      //         : null,
      //   ),
      // )
      ..dispatch(fetchDeviceType())
      ..dispatch(checkIfAppEnvChanged())
      ..dispatch(checkIfAppVersionWasUpdated());
    _locale = widget.store.state.userState.locale;
    initPlatformState();
    // screenListener.addScreenRecordListener((recorded) {
    //   ///Recorded was your record status (bool)
    //   setState(() {
    //     text = recorded ? "Start Recording" : "Stop Recording";
    //   });
    // });

    // screenListener
    //   ..addScreenShotListener((filePath) {
    //     ///filePath only available for Android
    //     _logScreenShot(
    //       screenshotFilePath: filePath,
    //     );
    //   })

    //   ///Start watch
    //   ..watch();
  }

  @override
  void dispose() {
    _sub?.cancel();
    // screenListener.dispose();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  /// See auto_router docs for mapping to existing routes
  /// ~ https://pub.dev/packages/auto_route#navigating-between-screens
  Future<void> initPlatformState() async {
    // ~ https://stackoverflow.com/a/59979431
    if (_type == UniLinksType.string) {
      await initPlatformStateForStringUniLinks();
    } else {
      await initPlatformStateForUriUniLinks();
    }
  }

  // Future<void> _logScreenShot({
  //   String? screenshotFilePath,
  // }) async {
  //   final storeJson = (await reduxStore).state.toJson();
  //   final widgetTree = debugDumpApp();
  //   await Sentry.captureMessage(
  //     jsonEncode({
  //       'reduxStore': storeJson,
  //       'widgetTree': widgetTree,
  //       'screenshotFilePath': screenshotFilePath ?? '',
  //     }),
  //     level: SentryLevel.debug,
  //   );
  //   log.info(
  //     {
  //       'reduxStore': storeJson,
  //       'widgetTree': widgetTree,
  //       'screenshotFilePath': screenshotFilePath ?? '',
  //     },
  //     stackTrace: StackTrace.current,
  //   );
  // }

  /// An implementation using a [String] link
  /// See auto_router docs for mapping to existing routes
  /// ~ https://pub.dev/packages/auto_route#navigating-between-screens
  Future<void> initPlatformStateForStringUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final latestLink = await getInitialLink();
      _latestLink = latestLink ?? 'Unknown';
      _latestUri = null;
      try {
        _latestUri = Uri.parse(_latestLink);
      } on FormatException {}
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
    } on PlatformException {
      _latestLink = 'Unknown';
      _latestUri = null;
      // Handle exception by warning the user their action did not succeed
      // return?
    }

    //Attach a listener to the links stream
    _sub = linkStream.listen(
      (String? link) {
        if (!mounted) return;
        setState(() {
          _latestLink = link ?? 'Unknown';
          _latestUri = null;
          try {
            if (link != null) {
              _latestUri = Uri.parse(link);
              // final relativeLink =
              //     _latestLink.replaceAll(RegExp(r'vegi://vegiApp.dev'), '');
              // log.info('Deep-linking to relative route: ${relativeLink}');
              if (_latestLink.startsWith('vegi')) {
                log.info('🔗 Push named link: $_latestLink');
                rootRouter.pushNamed(
                  _latestLink,
                );
              } else {
                log.info('Ignoring deep-linking route named: $_latestLink');
              }
            }
          } on FormatException {}
        });
      },
      onError: (Object? err) {
        if (!mounted) return;
        setState(() {
          _latestLink = 'Failed to get latest link: $err.';
          _latestUri = null;
        });
      },
    );

    // Attach a second listener to the stream
    linkStream.listen(
      (String? link) {
        log.info('🔗 router received link request: $link');
      },
      onError: (Object? err) {
        log.error(
          'got err: $err',
          stackTrace: StackTrace.current,
        );
      },
    );

    // Get the latest link
    String initialLink;
    Uri? initialUri;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink0 = await getInitialLink();
      print('initial link: $initialLink0');
      initialLink = initialLink0 ?? 'Unknown';
      if (initialLink0 != null) initialUri = Uri.parse(initialLink0);
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
      initialUri = null;
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
      initialUri = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestLink = initialLink;
      _latestUri = initialUri;
    });
  }

  /// An implementation using the [Uri] convenience helpers
  /// See auto_router docs for mapping to existing routes
  /// ~ https://pub.dev/packages/auto_route#navigating-between-screens
  Future<void> initPlatformStateForUriUniLinks() async {
    // Attach a listener to the Uri links stream
    _sub = uriLinkStream.listen(
      (Uri? uri) {
        if (!mounted) return;
        setState(() {
          _latestUri = uri;
          _latestLink = uri?.toString() ?? 'Unknown';
        });
      },
      onError: (Object? err) {
        if (!mounted) return;
        setState(() {
          _latestUri = null;
          _latestLink = 'Failed to get latest link: $err.';
        });
      },
    );

    // Attach a second listener to the stream
    uriLinkStream.listen(
      (Uri? uri) {
        print('got uri: ${uri?.path} ${uri?.queryParametersAll}');
      },
      onError: (Object? err) {
        print('got err: $err');
      },
    );

    // Get the latest Uri
    Uri? initialUri;
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialUri = await getInitialUri();
      print('initial uri: ${initialUri?.path}'
          ' ${initialUri?.queryParametersAll}');
      initialLink = initialUri?.toString() ?? 'Unknown';
    } on PlatformException {
      initialUri = null;
      initialLink = 'Failed to get initial uri.';
    } on FormatException {
      initialUri = null;
      initialLink = 'Bad parse the initial link as Uri.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestUri = initialUri;
      _latestLink = initialLink;
    });

    await rootRouter.pushNamed(_latestLink);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt.allReady(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasData) {
          return StoreProvider<AppState>(
            store: widget.store,
            child: DismissKeyboard(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: inDebugMode && !Env.isProd,
                locale: _locale,
                title: Strings.appName, // only for android
                theme: flexColorSchemeLight.toTheme,

                // themeMode: ThemeMode.system,
                // theme: getColorScheme(useFlex: true, isDark: false),
                // darkTheme: getColorScheme(useFlex: true, isDark: true),
                routeInformationParser: rootRouter.defaultRouteParser(),
                routerDelegate: rootRouter.delegate(
                  // initialDeepLink: ,
                  navigatorObservers: () => [
                    AutoRouteObserver(),
                    SentryNavigatorObserver(),
                    VegiDebugRouteObserver(),
                  ],
                ),
                builder: (_, router) => ResponsiveWrapper.builder(
                  router,
                  maxWidth: 1200,
                  minWidth: 400,
                  defaultScale: true,
                  breakpoints: [
                    const ResponsiveBreakpoint.resize(480, name: MOBILE),
                    const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                    const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                    const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                    const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
                  ],
                ),
                localizationsDelegates: const [
                  LocaleNamesLocalizationsDelegate(),
                  I10n.delegate,
                  CountryLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  FormBuilderLocalizations.delegate,
                ],
                supportedLocales: I10n.delegate.supportedLocales,
                localeListResolutionCallback: (locales, supportedLocales) {
                  for (final Locale locale in locales!) {
                    if (supportedLocales.contains(locale)) {
                      return locale;
                    }
                  }
                  return const Locale('en', 'US');
                },
                localeResolutionCallback: (locale, supportedLocales) {
                  for (final supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode &&
                        supportedLocale.countryCode == locale?.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
              ),
            ),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner:
                Secrets.VEGI_EATS_BACKEND.startsWith('http://localhost') &&
                    !Env.isProd,
            home: Scaffold(
              body: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: screenGradient,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/Vegi-Logo-square.png',
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
