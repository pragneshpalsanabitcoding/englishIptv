import 'dart:io';
import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:dio/dio.dart';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Ads/Ads File.dart';
import 'Ads/Open Ads.dart';
import 'Globle/Buttons.dart';
import 'Globle/GetController.dart';
import 'Globle/Guideline.dart';
import 'Globle/const.dart';
import 'main.dart';

class OpenChannelScreen extends StatefulWidget {
  const OpenChannelScreen({Key? key}) : super(key: key);

  @override
  State<OpenChannelScreen> createState() => _OpenChannelScreenState();
}

class _OpenChannelScreenState extends OpenAdState<OpenChannelScreen> {
  GlobalKey globalKey = GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();
  var link = modelApi?.comBitlinksEnglishIptvM3ulist!.extraUrl;
  final Directory pathhh =
      Directory("/storage/emulated/0/Download/$appbartitle");
  String datapath = "";

  checkFirstTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      bool? check = pref.getBool("guide");
      if (check == true) {
      } else {
        guideIntro(context);
      }
    });
  }

  guideIntro(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.h)),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                        ),
                        margin: const EdgeInsets.only(top: 30.0, right: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 0.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: 15.h,
                            ),
                            Center(
                                child: Padding(
                              padding: EdgeInsets.all(10.h),
                              child: Text("Welcome!",
                                  style: TextStyle(
                                      fontSize: 20.w,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ) //
                                ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Step 1",
                              style: TextStyle(
                                  color: downloadFileColor,
                                  fontSize: 20.w,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "Copy Link URL From download",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 17.w),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Step 2",
                              style: TextStyle(
                                  color: downloadLinkColor,
                                  fontSize: 20.w,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "Paste URL In video player app",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 17.w),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Step 3",
                              style: TextStyle(
                                  color: downloadQRCodeColor,
                                  fontSize: 20.w,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "Watch your favourite videos",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 17.w),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();

                                  pref.setBool("guide", true);

                                  Get.back();
                                },
                                child: buttonRed("Understood?")),
                            SizedBox(
                              height: 2.h,
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                playButtonImage,
                                height: 80.h,
                              )),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
        context: context);
  }

  Future<String> downloadFile() async {
    try {
      Dio dio = Dio();
      pathhh.create();
      datapath = pathhh.path;
      String filename = "$datapath/$fileSaveName${Random().nextInt(100)}.m3u";
      await dio.download(link!, filename);
      return filename;
    } catch (e) {
      return Future.value();
    }
  }

  Future takeScreenshot() async {
    String dirname = '${pathhh.path}/';
    pathhh.create();
    String filename = '$fileSaveName${Random().nextInt(100)}.png';

    final imageFile =
        await screenshotController.captureAndSave(dirname, fileName: filename);

    return imageFile;
  }

  //  dowaload file function
  downlodfiles() {
    downloadFile();
    FlutterClipboard.copy(link!).then((value) => showToast(
          'Download Successfully',
          context: context,
          animation: StyledToastAnimation.fadeScale,
          reverseAnimation: StyledToastAnimation.fadeScale,
          position: StyledToastPosition.center,
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 2),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear,
        ));
    showDialog(
        barrierColor: const Color(0xff050505).withOpacity(0.75),
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(left: 0, right: 0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: 40.h,
                      ),
                      margin: const EdgeInsets.only(top: 30.0, right: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 0.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 5.h,
                          ),
                          Center(
                              child: Padding(
                            padding: EdgeInsets.all(20.h),
                            child: Text("Download Successfully",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.w,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          )),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                showIntraAds(
                                    callback: () =>
                                        {Get.to(const GuideFile())});
                              },
                              child: buttonGrey("How to use")),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await LaunchApp.openApp(
                                  androidPackageName:
                                      '${modelApi!.comBitlinksEnglishIptvM3ulist!.iptvPlayerUrl}',
                                  iosUrlScheme: '',
                                  appStoreLink: '',
                                );
                              },
                              child: yellowWhite("Watch on IPTV App")),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              playButtonImage,
                              height: 80.h,
                            )),
                      ),
                    ),
                  ],
                ),
              ));
        },
        context: context);
  }

  //  Copy link function
  downloadlink() {
    FlutterClipboard.copy(
            '${modelApi!.comBitlinksEnglishIptvM3ulist!.extraUrl}')
        .then((value) => showToast(
              'Copy Successfully',
              context: context,
              animation: StyledToastAnimation.fadeScale,
              reverseAnimation: StyledToastAnimation.fadeScale,
              position: StyledToastPosition.center,
              animDuration: const Duration(seconds: 1),
              duration: const Duration(seconds: 2),
              curve: Curves.elasticOut,
              reverseCurve: Curves.linear,
            ));
    showDialog(
        barrierColor: const Color(0xff050505).withOpacity(0.75),
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(left: 0, right: 0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: 40.h,
                      ),

                      margin: const EdgeInsets.only(top: 30.0, right: 8.0),

                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 0.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 5.h,
                          ),
                          Center(
                              child: Padding(
                            padding: EdgeInsets.all(20.h),
                            child: Text("Download Successfully",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.w,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          )),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                showIntraAds(
                                    callback: () =>
                                        {Get.to(const GuideFile())});
                              },
                              child: buttonGrey("How to use")),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // var openAppResult =
                                await LaunchApp.openApp(
                                  androidPackageName:
                                      '${modelApi!.comBitlinksEnglishIptvM3ulist!.iptvPlayerUrl}',
                                  iosUrlScheme: '',
                                  appStoreLink: '',
                                );
                                // print('openAppResult => $openAppResult ${openAppResult.runtimeType}');
                              },
                              child: yellowWhite("Watch on IPTV App")),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              playButtonImage,
                              height: 80.h,
                            )),
                      ),
                    ),
                  ],
                ),
              ));
        },
        context: context);
  }

  //  dowaload QR Code function
  downloadQRcode() {
    print('Enter Dialod QrCode');
    takeScreenshot();
    FlutterClipboard.copy(
            '${modelApi!.comBitlinksEnglishIptvM3ulist!.extraUrl}')
        .then((value) {
      showToast(
        'Download Successfully',
        context: context,
        animation: StyledToastAnimation.fadeScale,
        reverseAnimation: StyledToastAnimation.fadeScale,
        position: StyledToastPosition.center,
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 2),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
      );
    });
    showDialog(
        barrierColor: const Color(0xff050505).withOpacity(0.75),
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(left: 0, right: 0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: 40.h,
                      ),
                      margin: const EdgeInsets.only(top: 30.0, right: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 0.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 5.h,
                          ),
                          Center(
                              child: Padding(
                            padding: EdgeInsets.all(20.h),
                            child: Text("Download Successfully",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.w,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          )),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                showIntraAds(
                                    callback: () =>
                                        {Get.to(const GuideFile())});
                              },
                              child: buttonGrey("How to use")),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // var openAppResult =
                                await LaunchApp.openApp(
                                  androidPackageName:
                                      '${modelApi!.comBitlinksEnglishIptvM3ulist!.iptvPlayerUrl}',
                                  iosUrlScheme: '',
                                  appStoreLink: '',
                                );
                              },
                              child: yellowWhite("Watch on IPTV App")),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              playButtonImage,
                              height: 80.h,
                            )),
                      ),
                    ),
                  ],
                ),
              ));
        },
        context: context);
  }

  Rewardpopupfile(BuildContext context) {
    if (modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence!.isNotEmpty) {
      if (modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.appVersionCode !=
          ControllerGetX.to.versionCode.value) {
        showDialog(
            barrierColor: const Color(0xff050505).withOpacity(0.75),
            barrierDismissible: false,
            context: context,
            builder: (a) {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: SimpleDialog(contentPadding: EdgeInsets.only(right: 9.w),
                  backgroundColor: Colors.transparent,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "Reward Ad",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 20.w),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Image.asset(
                                "images/new/popup_rewared.png",
                                height: 140.h,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey),
                                padding: EdgeInsets.all(5.h),
                                width: 1000.w,
                                margin: EdgeInsets.only(
                                    left: 30.w, right: 30.w, top: 20.h),
                                child: Text(
                                  modelApi!.comBitlinksEnglishIptvM3ulist!
                                      .rewardDialog!.rewardMessage!,
                                  style: TextStyle(
                                      fontSize: 18.w,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pop(context);
                                  showRewardAds(callback: () => {
                                    downlodfiles()
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.red),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40.w, vertical: 10.h),
                                  child: Text(
                                    "Watch Ad",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.w),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(10.h),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFFFFFF)
                                          .withOpacity(0.14)),
                                  child: Icon(
                                    Icons.close,
                                    size: 25.w,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              );
            });
      } else {}
    }
  }

  Rewardpopuplink(BuildContext context) {
    if (modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence!.isNotEmpty) {
      if (modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.appVersionCode !=
          ControllerGetX.to.versionCode.value) {
        showDialog(
            barrierColor: const Color(0xff050505).withOpacity(0.75),
            barrierDismissible: false,
            context: context,
            builder: (a) {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: SimpleDialog(contentPadding: EdgeInsets.only(right: 9.w),
                  backgroundColor: Colors.transparent,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "Reward Ad",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 20.w),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Image.asset(
                                "images/new/popup_rewared.png",
                                height: 140.h,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey),
                                padding: EdgeInsets.all(5.h),
                                width: 1000.w,
                                margin: EdgeInsets.only(
                                    left: 30.w, right: 30.w, top: 20.h),
                                child: Text(
                                  modelApi!.comBitlinksEnglishIptvM3ulist!
                                      .rewardDialog!.rewardMessage!,
                                  style: TextStyle(
                                      fontSize: 18.w,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pop(context);
                                  showRewardAds(callback: () => {
                                    downloadlink()
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.red),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40.w, vertical: 10.h),
                                  child: Text(
                                    "Watch Ad",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.w),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(10.h),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFFFFFF)
                                          .withOpacity(0.14)),
                                  child: Icon(
                                    Icons.close,
                                    size: 25.w,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              );
            });
      } else {}
    }
  }

  RewardpopupQR(BuildContext context) {
    if (modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence!.isNotEmpty) {
      if (modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.appVersionCode !=
          ControllerGetX.to.versionCode.value) {
        showDialog(
            barrierColor: const Color(0xff050505).withOpacity(0.75),
            barrierDismissible: false,
            context: context,
            builder: (a) {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: SimpleDialog(contentPadding: EdgeInsets.only(right: 9.w),
                  backgroundColor: Colors.transparent,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "Reward Ad",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 20.w),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Image.asset(
                                "images/new/popup_rewared.png",
                                height: 140.h,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey),
                                padding: EdgeInsets.all(5.h),
                                width: 1000.w,
                                margin: EdgeInsets.only(
                                    left: 30.w, right: 30.w, top: 20.h),
                                child: Text(
                                  modelApi!.comBitlinksEnglishIptvM3ulist!
                                      .rewardDialog!.rewardMessage!,
                                  style: TextStyle(
                                      fontSize: 18.w,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pop(context);
                                  showRewardAds(callback: () =>  {
                                    downloadQRcode()
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.red),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40.w, vertical: 10.h),
                                  child: Text(
                                    "Watch Ad",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.w),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(10.h),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFFFFFF)
                                          .withOpacity(0.14)),
                                  child: Icon(
                                    Icons.close,
                                    size: 25.w,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              );
            });
      } else {}
    }
  }

  fileDialog() {
    showDialog(
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.h)),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      top: 25.0,
                    ),
                    margin: const EdgeInsets.only(top: 30.0, right: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 0.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 30.h,
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("File",
                              style: TextStyle(
                                  fontSize: 20.w,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ) //
                            ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Image.asset(
                          "images/fileimage.png",
                          height: 70.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            "Download file to your device and know everything",
                            style: TextStyle(
                                color: const Color(0xff707070), fontSize: 17.w),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              forPermission().then((value) {
                                isFullAdss(
                                    callback: () => {Rewardpopupfile(context)});
                              });
                            },
                            child: buttonRed("Download")),
                        InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await LaunchApp.openApp(
                                androidPackageName:
                                    '${modelApi!.comBitlinksEnglishIptvM3ulist!.iptvPlayerUrl}',
                                iosUrlScheme: '',
                                appStoreLink: '',
                              );
                              Get.back();
                            },
                            child: yellowWhite("Watch on IPTV App")),
                        InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              downloadFile().then((value) {
                                Share.shareFiles([value]);
                              });
                            },
                            child: buttonGrey("Share")),
                        SizedBox(
                          height: 2.h,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            playButtonImage,
                            height: 80.h,
                          )),
                    ),
                  ),
                ],
              ));
        },
        context: context);
  }

  linkDialog() {
    // FlutterClipboard.copy(link!).then((value) =>
    showDialog(
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                      ),
                      margin: const EdgeInsets.only(top: 30.0, right: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 0.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 30.h,
                          ),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Copy Link",
                                style: TextStyle(
                                    fontSize: 20.w,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ) //
                              ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Image.asset(
                            "images/linkimage.png",
                            height: 70.h,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.h),
                            child: Text(
                              "Copy link and you can watch live HD videos on your device",
                              style: TextStyle(
                                  color: const Color(0xff707070),
                                  fontSize: 17.w),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                forPermission().then((value) {
                                  isFullAdss(
                                      callback: Rewardpopuplink(context));
                                });
                              },
                              child: buttonRed("Copy Link")),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              // var openAppResult =
                              await LaunchApp.openApp(
                                androidPackageName:
                                    '${modelApi!.comBitlinksEnglishIptvM3ulist!.iptvPlayerUrl}',
                                iosUrlScheme: '',
                                appStoreLink: '',
                              );
                              // print('openAppResult => $openAppResult ${openAppResult.runtimeType}');
                              Get.back();
                            },
                            child: yellowWhite("Watch on IPTV App"),
                          ),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Share.share(
                                    "${modelApi!.comBitlinksEnglishIptvM3ulist!.extraUrl}");
                              },
                              child: buttonGrey("Share")),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              playButtonImage,
                              height: 80.h,
                            )),
                      ),
                    ),
                  ],
                ),
              ));
        },
        context: context);
    // );
  }

  qrDialog() {
    showDialog(
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                      ),
                      margin: const EdgeInsets.only(top: 30.0, right: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 0.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 30.h,
                          ),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("QR Code",
                                style: TextStyle(
                                    fontSize: 20.w,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          )),
                          RepaintBoundary(
                            key: globalKey,
                            child: Screenshot(
                              controller: screenshotController,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: QrImage(
                                    data:
                                        "${modelApi!.comBitlinksEnglishIptvM3ulist!.extraUrl}",
                                    version: QrVersions.auto,
                                    size: 170.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Text(
                              "download QR Code and scan with any scanner",
                              style: TextStyle(
                                  color: const Color(0xff707070),
                                  fontSize: 17.w),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                forPermission().then((value) {
                                  isFullAdss(callback: RewardpopupQR(context));
                                });
                              },
                              child: buttonRed("Download")),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // var openAppResult =
                                await LaunchApp.openApp(
                                  androidPackageName:
                                      '${modelApi!.comBitlinksEnglishIptvM3ulist!.iptvPlayerUrl}',
                                  iosUrlScheme: '',
                                  appStoreLink: '',
                                );
                                // print('openAppResult => $openAppResult ${openAppResult.runtimeType}');
                                Get.back();
                              },
                              child: yellowWhite("Watch on IPTV App")),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                takeScreenshot().then((value) async {
                                  Future.delayed(const Duration(seconds: 0),
                                      () {
                                    Share.shareFiles(["${(value)}"]);
                                  });
                                });
                              },
                              child: buttonGrey("Share")),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              playButtonImage,
                              height: 80.h,
                            )),
                      ),
                    ),
                  ],
                ),
              ));
        },
        context: context);
  }

  Future forPermission() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      [Permission.storage].request;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pathhh.create();
    Future.delayed(
      const Duration(seconds: 0),
      () {
        checkFirstTime();
        updateDialoug();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (ctx) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.h),
                        topRight: Radius.circular(30.h))),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(height: 25.h),
                  Text(
                      '${modelApi!.comBitlinksEnglishIptvM3ulist!.exitDialog!.exitTitle}',
                      style: TextStyle(
                          fontSize: 20.w, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h),
                  Text(
                      "${modelApi?.comBitlinksEnglishIptvM3ulist!.exitDialog!.exitMessage}"),
                  SizedBox(height: 10.h),
                  mediumNativeAds(),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Get.back();
                            Share.share(
                                "${modelApi!.comBitlinksEnglishIptvM3ulist!.shareApp!.shareTitle}");
                          },
                          child: const Icon(Icons.share)),
                      InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Get.back();
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierColor: const Color(0xd7050505),
                                builder: (context) => RatingDialog(
                                      image: Image.asset(
                                        logo,
                                        height: 100.h,
                                        width: 100.w,
                                      ),

                                      initialRating: 5.0,
                                      title: Text(
                                        '${modelApi!.comBitlinksEnglishIptvM3ulist!.aboutApp!.aboutTitle}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // encourage your user to leave a high rating?
                                      message: Text(
                                        '${modelApi!.comBitlinksEnglishIptvM3ulist!.rateApp!.rateMessage}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      // your app's logo?
                                      submitButtonText: 'Submit',
                                      onCancelled: () {},
                                      onSubmitted: (response) {
                                        // TODO: add your own logic
                                        if (response.rating <= 2.0) {
                                          MotionToast.success(
                                            title: const Text(
                                                "Thanks For Your Rating"),
                                            description: const Text(
                                                "We Will Improve App"),
                                            width: 300,
                                            height: 80,
                                          ).show(context);
                                        } else {
                                          launch(
                                              "${modelApi!.comBitlinksEnglishIptvM3ulist!.rateApp!.rateAppUrl}");
                                        }
                                      },
                                      starSize: 30,
                                    ));
                          },
                          child: const Icon(Icons.star)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            exit(0);
                          },
                          child: Container(
                            margin: EdgeInsets.all(10.h),
                            alignment: Alignment.center,
                            width: 40.w,
                            height: 35.h,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            margin: EdgeInsets.all(10.h),
                            alignment: Alignment.center,
                            width: 40.w,
                            height: 35.h,
                            decoration: const BoxDecoration(
                                color: Color(0xffffe234),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              );
            });
        return false;
      },
      child: Scaffold(
        backgroundColor: themColor,
        bottomNavigationBar: bannerAds(),
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(1.h),
              child: PopupMenuButton(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                iconSize: 3.h,
                itemBuilder: (ctx) => [
                  _buildPopupMenuItem('Privacy Policy', () {
                    launch(
                        "${modelApi!.comBitlinksEnglishIptvM3ulist!.privacyPolicy!.privacyPolicy}");
                  }, ""),
                  _buildPopupMenuItem('Rate us', () {
                    Future.delayed(const Duration(seconds: 0), () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierColor: Colors.black45,
                          useSafeArea: true,
                          // set to false if you want to force a rating
                          builder: (context) => RatingDialog(
                                image: Image.asset(
                                  logo,
                                  height: 100.h,
                                  width: 100.w,
                                ),
                                initialRating: 5.0,
                                title: Text(
                                  "${modelApi!.comBitlinksEnglishIptvM3ulist!.aboutApp!.aboutTitle}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // encourage your user to leave a high rating?
                                message: Text(
                                  '${modelApi?.comBitlinksEnglishIptvM3ulist!.rateApp!.rateMessage}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                // your app's logo?
                                submitButtonText: 'Submit',
                                onCancelled: () {},
                                onSubmitted: (response) {
                                  // TODO: add your own logic
                                  if (response.rating <= 2.0) {
                                    MotionToast.success(
                                      title:
                                          const Text("Thanks For Your Rating"),
                                      description:
                                          const Text("We Will Improve App"),
                                      width: 300,
                                      height: 80,
                                    ).show(context);
                                  } else {
                                    launch(
                                        "${modelApi!.comBitlinksEnglishIptvM3ulist!.rateApp!.rateAppUrl}");
                                  }
                                },
                                starSize: 30,
                              ));
                    });
                  }, ""),
                  _buildPopupMenuItem('More App', () {
                    launch(
                        "${modelApi!.comBitlinksEnglishIptvM3ulist!.moreAppUrl}");
                  }, "(Ad)"),
                  _buildPopupMenuItem('Terms & Conditions', () {
                    launch(
                        "${modelApi!.comBitlinksEnglishIptvM3ulist!.termsOfUse!.termsOfUse}");
                  }, ""),
                  _buildPopupMenuItem('Feedback', () {
                    launch(
                        "${modelApi!.comBitlinksEnglishIptvM3ulist!.feedbackSupport!.emailId}?subject=${modelApi!.comBitlinksEnglishIptvM3ulist!.feedbackSupport!.emailSubject}&body=${modelApi!.comBitlinksEnglishIptvM3ulist!.feedbackSupport!.emailMessage}");
                  }, ""),
                  _buildPopupMenuItem('About Us', () {
                    Future.delayed(const Duration(seconds: 0), () {
                      showAboutUs(context);
                    });
                  }, ""),
                  _buildPopupMenuItem('Exit', () {
                    Future.delayed(const Duration(seconds: 0), () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (ctx) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.h),
                                      topRight: Radius.circular(30.h))),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 25.h),
                                    Text(
                                        '${modelApi!.comBitlinksEnglishIptvM3ulist!.exitDialog!.exitTitle}',
                                        style: TextStyle(
                                            fontSize: 20.w,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10.h),
                                    Text(
                                        "${modelApi?.comBitlinksEnglishIptvM3ulist!.exitDialog!.exitMessage}"),
                                    SizedBox(height: 10.h),
                                    mediumNativeAds(),
                                    SizedBox(height: 15.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Get.back();
                                              Share.share(
                                                  "${modelApi!.comBitlinksEnglishIptvM3ulist!.shareApp!.shareTitle}");
                                            },
                                            child: const Icon(Icons.share)),
                                        InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Get.back();
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  barrierColor:
                                                      const Color(0xd7050505),
                                                  builder: (context) =>
                                                      RatingDialog(
                                                        image: Image.asset(
                                                          logo,
                                                          height: 100.h,
                                                          width: 100.w,
                                                        ),

                                                        initialRating: 5.0,
                                                        title: Text(
                                                          '${modelApi!.comBitlinksEnglishIptvM3ulist!.aboutApp!.aboutTitle}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        // encourage your user to leave a high rating?
                                                        message: Text(
                                                          '${modelApi!.comBitlinksEnglishIptvM3ulist!.rateApp!.rateMessage}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15),
                                                        ),
                                                        // your app's logo?
                                                        submitButtonText:
                                                            'Submit',
                                                        onCancelled: () {},
                                                        onSubmitted:
                                                            (response) {
                                                          // TODO: add your own logic
                                                          if (response.rating <=
                                                              2.0) {
                                                            MotionToast.success(
                                                              title: const Text(
                                                                  "Thanks For Your Rating"),
                                                              description:
                                                                  const Text(
                                                                      "We Will Improve App"),
                                                              width: 300,
                                                              height: 80,
                                                            ).show(context);
                                                          } else {
                                                            launch(
                                                                "${modelApi!.comBitlinksEnglishIptvM3ulist!.rateApp!.rateAppUrl}");
                                                          }
                                                        },
                                                        starSize: 30,
                                                      ));
                                            },
                                            child: const Icon(Icons.star)),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              exit(0);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(10.h),
                                              alignment: Alignment.center,
                                              width: 40.w,
                                              height: 35.h,
                                              decoration: const BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: const Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(10.h),
                                              alignment: Alignment.center,
                                              width: 40.w,
                                              height: 35.h,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffffe234),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: const Text(
                                                "No",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            );
                          });
                    });
                  }, ""),
                ],
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Text(appbartitle, style: TextStyle(fontSize: 20.h)),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          mediumNativeAds(),
          SizedBox(
            height: 20.h,
          ),
          //todo DownloadFile
          Container(
            height: 60.h,
            width: double.infinity,
            color: Colors.transparent,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  pathhh.create();
                  Permission.storage.request().then((value) {
                    ControllerGetX.to.isIntraAdsShow.value=true;
                    showIntraAds(callback: () => {
                    ControllerGetX.to.isIntraAdsShow.value=false,
                      fileDialog()});
                  });
                },
                child: SizedBox(
                  width: 180.w,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20.w),
                        alignment: Alignment.center,
                        height: 70.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                          color: downloadFileColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.h),
                          ),
                        ),
                        child: Text('File',
                            style: TextStyle(
                                fontSize: 18.h,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(right: 130.w),
                          padding: EdgeInsets.all(10.h),
                          height: 45.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.h),
                            ),
                          ),
                          child: Image.asset(downloadFileImage),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  showIntraAds(callback: () => {Get.to(const GuideFile())});
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  height: 70.h,
                  width: 80.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0x1affffff),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.h),
                      )),
                  child: Text('Guide',
                      style: TextStyle(fontSize: 18.h, color: Colors.white)),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10.h,
          ),

          // todo DownloadLink
          Container(
            height: 60.h,
            width: double.infinity,
            color: Colors.transparent,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
    ControllerGetX.to.isIntraAdsShow.value=true;
    showIntraAds(callback: () => {
    ControllerGetX.to.isIntraAdsShow.value=false,
                    linkDialog()});
                  });
                },
                child: SizedBox(
                  width: 180.w,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20.w),
                        alignment: Alignment.center,
                        height: 70.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                          color: downloadLinkColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.h),
                          ),
                        ),
                        child: Text('Link',
                            style: TextStyle(
                                fontSize: 18.h,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(right: 130.w),
                          padding: EdgeInsets.all(10.h),
                          height: 45.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.h),
                            ),
                          ),
                          child: Image.asset(downloadLinkImage),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  showIntraAds(callback: () => {Get.to(const GuideLink())});
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  height: 70.h,
                  width: 80.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0x1affffff),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.h),
                      )),
                  child: Text('Guide',
                      style: TextStyle(fontSize: 18.h, color: Colors.white)),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10.h,
          ),
          // todo DownloadQR
          Container(
            height: 60.h,
            width: double.infinity,
            color: Colors.transparent,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Permission.storage.request().then((value) {
                    showIntraAds(callback: qrDialog());
                  });
                },
                child: SizedBox(
                  width: 180.w,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20.w),
                        alignment: Alignment.center,
                        height: 70.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                          color: downloadQRCodeColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.h),
                          ),
                        ),
                        child: Text('QR Code',
                            style: TextStyle(
                                fontSize: 18.h,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(right: 130.w),
                          padding: EdgeInsets.all(10.h),
                          height: 45.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.h),
                            ),
                          ),
                          child: Image.asset(downloadQRCodeImage),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showIntraAds(callback: () => {Get.to(const GuideQr())});
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  height: 70.h,
                  width: 80.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0x1affffff),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.h),
                      )),
                  child: Text('Guide',
                      style: TextStyle(fontSize: 18.h, color: Colors.white)),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20.h,
          ),
          isFullAdssNative()
        ]),
      ),
    );
  }


PopupMenuItem _buildPopupMenuItem(
    String title, VoidCallback? tapEvent, var ad) {
  return PopupMenuItem(
    onTap: tapEvent,
    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      SizedBox(width: 2.w),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
          child: Text(
            "$ad",
            style: TextStyle(fontSize: 3.2.w, color: Colors.grey),
          ),
        ),
      ),
    ]),
  );
}
