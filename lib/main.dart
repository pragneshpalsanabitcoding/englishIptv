import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_applovin_unity_ads/google_applovin_unity_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'Check Internet.dart';
import 'Globle/GetController.dart';
import 'Globle/Provider.dart';
import 'Globle/SettingsModel.dart';
import 'SplashScreen1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  ControllerGetX.to.versionCode.value = int.parse(packageInfo.buildNumber);

  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi){
    await fetchAlbum();

    if ((modelApi?.comBitlinksEnglishIptvM3ulist ?? "").toString().isNotEmpty) {
      GoogleApplovinUnityAds.initialize(
          jsonEncode(modelApi?.comBitlinksEnglishIptvM3ulist).toString(),
          callback: () => {runApp(ScreenUtilInit(
            builder: (BuildContext context, Widget? child) {
              return const GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: IPTV(),
              );
            },
          ))});
    }
    else {
      runApp(const GetMaterialApp(debugShowCheckedModeBanner: false,
        home: CheckInternet(),));
    }


  }



}

Settings? modelApi;

class IPTV extends StatefulWidget {
  const IPTV({Key? key}) : super(key: key);

  static String oneSignalAppId =
      '${modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.onesignalId}';

  @override
  State<IPTV> createState() => _IPTVState();
}

class _IPTVState extends State<IPTV> {

  Future<void> initPlatformState() async {
    if (modelApi!.comBitlinksEnglishIptvM3ulist!.privacyPolicy != null) {
      OneSignal.shared.setAppId(IPTV.oneSignalAppId);
      OneSignal.shared
          .promptUserForPushNotificationPermission()
          .then((accepted) {});
    }
  }
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
