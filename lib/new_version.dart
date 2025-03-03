import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/version.dart';

/// Information about the app's current version, and the most recent version
/// available in the Apple App Store or Google Play Store.
class VersionStatus {

  VersionStatus._({
    required this.localVersion,
    required this.storeVersion,
    required this.appStoreLink,
    this.releaseNotes,
  });
  /// The current version of the app.
  final String localVersion;
  Version? get localVersionParsed => Version.tryParse(localVersion);

  /// The most recent version of the app in the store.
  final String storeVersion;
  Version? get storeVersionParsed => Version.tryParse(storeVersion);

  /// A link to the app store page where the app can be updated.
  final String appStoreLink;

  /// A link to the app store page where the app can be updated.
  Uri get appStoreLinkUri => Uri.parse(appStoreLink);

  /// The release notes for the store version of the app.
  final String? releaseNotes;

  /// Returns `true` if the store version of the application is greater than the local version.
  bool get canUpdate {
    try {
      if (!Version.isWellFormatted(localVersion) ||
          !Version.isWellFormatted(storeVersion)) {
        return false;
      }

      final local = localVersion.split('.').map(int.parse).toList();
      final store = storeVersion.split('.').map(int.parse).toList();

      // Each consecutive field in the version notation is less significant than the previous one,
      // therefore only one comparison needs to yield `true` for it to be determined that the store
      // version is greater than the local version.
      for (var i = 0; i < store.length; i++) {
        // The store version field is newer than the local version.
        if (store[i] > local[i]) {
          return true;
        }

        // The local version field is newer than the store version.
        if (local[i] > store[i]) {
          return false;
        }
      }

      // The local and store versions are the same.
      return false;
    } on Exception catch (e, s) {
      log.error(
        e,
        stackTrace: s,
      );
      return false;
    }
  }
}

class NewVersion {

  NewVersion({
    this.androidId,
    this.iOSId,
    this.iOSAppStoreCountry,
    this.forceAppVersion,
  });
  /// An optional value that can override the default packageName when
  /// attempting to reach the Apple App Store. This is useful if your app has
  /// a different package name in the App Store.
  final String? iOSId;

  /// An optional value that can override the default packageName when
  /// attempting to reach the Google Play Store. This is useful if your app has
  /// a different package name in the Play Store.
  final String? androidId;

  /// Only affects iOS App Store lookup: The two-letter country code for the store you want to search.
  /// Provide a value here if your app is only available outside the US.
  /// For example: US. The default is US.
  /// See http://en.wikipedia.org/wiki/ ISO_3166-1_alpha-2 for a list of ISO Country Codes.
  final String? iOSAppStoreCountry;

  /// An optional value that will force the plugin to always return [forceAppVersion]
  /// as the value of [storeVersion]. This can be useful to test the plugin's behavior
  /// before publishng a new version.
  final String? forceAppVersion;

  static Future<NewVersion> fromPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return NewVersion(
      iOSAppStoreCountry:
          'GB', // ~ https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
      iOSId: packageInfo.packageName,
      androidId: packageInfo.packageName,
    );
  }

  /// This checks the version status, then displays a platform-specific alert
  /// with buttons to dismiss the update alert, or go to the app store.
  showAlertIfNecessary({required BuildContext context}) async {
    final VersionStatus? versionStatus = await getVersionStatus();
    if (versionStatus != null && versionStatus.canUpdate) {
      await showUpdateDialog(context: context, versionStatus: versionStatus);
    }
  }

  /// This checks the version status and returns the information. This is useful
  /// if you want to display a custom alert, or use the information in a different
  /// way.
  Future<VersionStatus?> getVersionStatus() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isIOS) {
      return _getiOSStoreVersion(packageInfo);
    } else if (Platform.isAndroid) {
      return _getAndroidStoreVersion(packageInfo);
    } else {
      log.warn(
          'The target platform "${Platform.operatingSystem}" is not yet supported by this package.',);
      return null;
    }
  }

  /// This function attempts to clean local version strings so they match the MAJOR.MINOR.PATCH
  /// versioning pattern, so they can be properly compared with the store version.
  String _getCleanVersion(String version) =>
      RegExp(r'\d+\.\d+\.\d+').stringMatch(version) ?? '0.0.0';

  Version _parseCleanVersion(String cleanVersion) =>
      Version.parse(cleanVersion);

  /// iOS info is fetched by using the iTunes lookup API, which returns a
  /// JSON document.
  Future<VersionStatus?> _getiOSStoreVersion(PackageInfo packageInfo) async {
    final id = iOSId ?? packageInfo.packageName;
    final parameters = {'bundleId': id};
    if (iOSAppStoreCountry != null) {
      parameters.addAll({'country': iOSAppStoreCountry!});
    }
    final uri = Uri.https('itunes.apple.com', '/lookup', parameters);
    final response = await http.get(
      uri,
    ); // ~ https://itunes.apple.com/lookup?country=GB&bundleId=com.vegiapp.vegi
    if (response.statusCode != 200) {
      log.error(
        'Failed to query iOS App Store',
        stackTrace: StackTrace.current,
      );
      return null;
    }
    final jsonObj = json.decode(response.body) as Map<String, dynamic>;
    final results = jsonObj['results'] as List<dynamic>;
    if (results.isEmpty) {
      if (id.toLowerCase().contains('test')) {
        return VersionStatus._(
          localVersion: _getCleanVersion(PackageConstants.buildVersion()),
          storeVersion: '',
          appStoreLink: '',
          releaseNotes: '',
        );
      }
      log.warn(
        "Can't find an app in the App Store with the id: $id",
        stackTrace: StackTrace.current,
      );
      return VersionStatus._(
        localVersion: _getCleanVersion(PackageConstants.buildVersion()),
        storeVersion: '',
        appStoreLink: '',
        releaseNotes: '',
      );
    }
    final firstResult = results.first as Map<String, dynamic>;
    return VersionStatus._(
      localVersion: _getCleanVersion(PackageConstants.buildVersion()),
      storeVersion: _getCleanVersion(
        forceAppVersion ?? ((firstResult['version'] ?? '') as String),
      ),
      appStoreLink: (firstResult['trackViewUrl'] ?? '') as String,
      releaseNotes: (firstResult['releaseNotes'] ?? '') as String,
    );
  }

  /// Android info is fetched by parsing the html of the app store page.
  Future<VersionStatus?> _getAndroidStoreVersion(
      PackageInfo packageInfo,) async {
    final id = androidId ?? packageInfo.packageName;
    final uri = Uri.https(
        'play.google.com', '/store/apps/details', {'id': id, 'hl': 'en'},);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      log.warn("Can't find an app in the Play Store with the id: $id");
      return VersionStatus._(
        localVersion: _getCleanVersion(PackageConstants.buildVersion()),
        storeVersion: '',
        appStoreLink: '',
        releaseNotes: '',
      );
    }
    final document = parse(response.body);

    String storeVersion = '0.0.0';
    String? releaseNotes;

    final additionalInfoElements = document.getElementsByClassName('hAyfc');
    if (additionalInfoElements.isNotEmpty) {
      final versionElement = additionalInfoElements.firstWhere(
        (elm) => elm.querySelector('.BgcNfc')!.text == 'Current Version',
      );
      storeVersion = versionElement.querySelector('.htlgb')!.text;

      final sectionElements = document.getElementsByClassName('W4P4ne');
      final releaseNotesElement = sectionElements.firstWhereOrNull(
        (elm) => elm.querySelector('.wSaTQd')!.text == "What's New",
      );
      releaseNotes = releaseNotesElement
          ?.querySelector('.PHBdkd')
          ?.querySelector('.DWPxHb')
          ?.text;
    } else {
      final scriptElements = document.getElementsByTagName('script');
      final infoScriptElement = scriptElements.firstWhere(
        (elm) => elm.text.contains("key: 'ds:4'"),
      );

      final param = infoScriptElement.text
          .substring(20, infoScriptElement.text.length - 2)
          .replaceAll('key:', '"key":')
          .replaceAll('hash:', '"hash":')
          .replaceAll('data:', '"data":')
          .replaceAll('sideChannel:', '"sideChannel":')
          .replaceAll("'", '"');
      final parsed = json.decode(param);
      final data = parsed['data'];

      storeVersion = data[1][2][140][0][0][0] as String;
      releaseNotes = data[1][2][144][1][1] as String;
    }

    return VersionStatus._(
      localVersion: _getCleanVersion(PackageConstants.buildVersion()),
      storeVersion: _getCleanVersion(forceAppVersion ?? storeVersion),
      appStoreLink: uri.toString(),
      releaseNotes: releaseNotes,
    );
  }

  /// Shows the user a platform-specific alert about the app update. The user
  /// can dismiss the alert or proceed to the app store.
  ///
  /// To change the appearance and behavior of the update dialog, you can
  /// optionally provide [dialogTitle], [dialogText], [updateButtonText],
  /// [dismissButtonText], and [dismissAction] parameters.
  Future<void> showUpdateDialog({
    required BuildContext context,
    required VersionStatus versionStatus,
    String dialogTitle = 'Update Available',
    String? dialogText,
    String updateButtonText = 'Update',
    bool allowDismissal = true,
    String dismissButtonText = 'Maybe Later',
    VoidCallback? dismissAction,
  }) async {
    final dialogTitleWidget = Text(dialogTitle);
    final dialogTextWidget = Text(
      dialogText ??
          'You can now update this app from ${versionStatus.localVersion} to ${versionStatus.storeVersion}',
    );

    final updateButtonTextWidget = Text(updateButtonText);
    void updateAction() {
      launchAppStore(versionStatus.appStoreLinkUri);
      if (allowDismissal) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    List<Widget> actions = [
      if (Platform.isAndroid) TextButton(
              onPressed: updateAction,
              child: updateButtonTextWidget,
            ) else CupertinoDialogAction(
              onPressed: updateAction,
              child: updateButtonTextWidget,
            ),
    ];

    if (allowDismissal) {
      final dismissButtonTextWidget = Text(dismissButtonText);
      dismissAction = dismissAction ??
          () => Navigator.of(context, rootNavigator: true).pop();
      actions.add(
        Platform.isAndroid
            ? TextButton(
                onPressed: dismissAction,
                child: dismissButtonTextWidget,
              )
            : CupertinoDialogAction(
                onPressed: dismissAction,
                child: dismissButtonTextWidget,
              ),
      );
    }

    await showDialog(
      context: context,
      barrierDismissible: allowDismissal,
      builder: (BuildContext context) {
        return WillPopScope(
            child: Platform.isAndroid
                ? AlertDialog(
                    title: dialogTitleWidget,
                    content: dialogTextWidget,
                    actions: actions,
                  )
                : CupertinoAlertDialog(
                    title: dialogTitleWidget,
                    content: dialogTextWidget,
                    actions: actions,
                  ),
            onWillPop: () => Future.value(allowDismissal),);
      },
    );
  }

  /// Launches the Apple App Store or Google Play Store page for the app.
  Future<void> launchAppStore(Uri appStoreLink) async {
    log.verbose(
      appStoreLink.toString(),
      stackTrace: StackTrace.current,
    );
    if (await canLaunchUrl(appStoreLink)) {
      await launchUrl(appStoreLink);
    } else {
      throw Exception('Could not launch appStoreLink: $appStoreLink');
    }
  }
}
