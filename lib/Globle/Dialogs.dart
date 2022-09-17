import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'GetController.dart';
import 'const.dart';

exitDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.TOPSLIDE,
    headerAnimationLoop: true,
    dialogType: DialogType.WARNING,
    btnOk: Column(mainAxisSize: MainAxisSize.min,
      children: [
        // smallNativeAds(),
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
                child: const Icon(
                  Icons.share,
                  size: 30,
                )),
            InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.back();
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => RatingDialog(
                        image: Image.asset(
                          logo,
                          height: 15.h,
                          width: 15.w,
                        ),
                        initialRating: 5.0,
                        title: const Text(
                          'IPTV',
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
                              title: const Text("Thanks For Your Rating"),
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
                },
                child: const Icon(
                  Icons.star,
                  size: 30,
                )),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  exit(0);
                },
                child: Container(
                  margin: EdgeInsets.all(1.h),
                  alignment: Alignment.center,
                  width: 45.w,
                  height: 30.h,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
                  margin: EdgeInsets.all(1.h),
                  alignment: Alignment.center,
                  width: 45.w,
                  height: 30.h,
                  decoration: const BoxDecoration(
                      color: Color(0xffffe234),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const Text(
                    "No",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    showCloseIcon: false,
    title: '${modelApi!.comBitlinksEnglishIptvM3ulist!.exitDialog!.exitTitle}',
    desc: "${modelApi!.comBitlinksEnglishIptvM3ulist!.exitDialog!.exitMessage}",
    titleTextStyle: TextStyle(fontSize: 20.w, fontWeight: FontWeight.bold),
  ).show();
}

Future<void> showAboutUs(BuildContext context) async {
  // String appName = await GetVersion.appName;
  // String projectVersion = await GetVersion.projectVersion;

  return showAboutDialog(
    context: context,
    applicationIcon: SizedBox(
      height: 100.sp,
      width: 100.sp,
      child: Image(
        image: AssetImage(logo),
        fit: BoxFit.contain,
        alignment: Alignment.bottomCenter,
      ),
    ),
    applicationLegalese:
    modelApi!.comBitlinksEnglishIptvM3ulist!.aboutApp!.registrationDetail,
    applicationName: apptitle,
    // anchorPoint: ,
    applicationVersion: '${ControllerGetX.to.versionCode.value}',
    children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Text(
              "${modelApi!.comBitlinksEnglishIptvM3ulist!.aboutApp!.aboutMessage}")),
    ],
  );
}

updateDialoug() {
  (modelApi!.comBitlinksEnglishIptvM3ulist?.appUpdate!.isPopupDialog == true &&
      (modelApi!.comBitlinksEnglishIptvM3ulist?.appUpdate!.updatedVersionCode ?? 1) > ControllerGetX.to.versionCode.value) ? Future.delayed(const Duration(seconds: 1), () {
    Get.defaultDialog(
        onWillPop: () async {
          if (modelApi!.comBitlinksEnglishIptvM3ulist?.appUpdate!.isUpdateRequire ==
              true) {
            return false;
          } else {
            return true;
          }
        },
        content: Image.network(
          '${modelApi!.comBitlinksEnglishIptvM3ulist!.appUpdate!.appIcon}',
          height: 100.h, width: 100.h,),
        actions: [
          Center(
            child: Column(
              children: [
                Text(
                    "${modelApi!.comBitlinksEnglishIptvM3ulist?.appUpdate!
                        .title}",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                Text(
                    "\n${modelApi!.comBitlinksEnglishIptvM3ulist?.appUpdate!
                        .defaultMessage}",
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          )
        ],
        backgroundColor: Colors.white,
        titleStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold),
        middleTextStyle: const TextStyle(
          color: Colors.white,
        ),
        confirm: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: modelApi!.comBitlinksEnglishIptvM3ulist?.appUpdate!
                  .isUpdateRequire ==
                  true
                  ? 0.w
                  : 5.w,
            ),
            modelApi!.comBitlinksEnglishIptvM3ulist?.appUpdate!
                .isUpdateRequire! !=
                true
                ? InkWell(splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Get.back();
              },
              child: Container(margin: EdgeInsets.all(3.h),
                padding: EdgeInsets.all(10.h),
                child: const Text(
                  "No Thanks",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
                : Container(),
            SizedBox(
              width: modelApi!.comBitlinksEnglishIptvM3ulist!.appUpdate!
                  .isUpdateRequire ==
                  true
                  ? 0.w
                  : 10.w,
            ),
            InkWell(splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                // ignore: deprecated_member_use
                launch(
                    "${modelApi!.comBitlinksEnglishIptvM3ulist!.appUpdate!
                        .websiteUrl}");
              },
              child: Stack(
                children: [
                  Container(margin: EdgeInsets.all(3.h),
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(color: themeButtonColor,borderRadius: BorderRadius.all(Radius.circular(10.h))),
                    child: const Text(
                      "Download (Ad)",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: modelApi!.comBitlinksEnglishIptvM3ulist!.appUpdate!
                  .isUpdateRequire ==
                  true
                  ? 0.w
                  : 5.w,
            ),
          ],
        ),
        radius: 20.h);
  })
      : Container();
}

aboutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (a) {
        return SimpleDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(2.h),
          alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.h),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Text(
                    "About Us",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 25.w),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Text("Privacy Policy"),
                  InkWell(splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      launch(
                          "${modelApi!.comBitlinksEnglishIptvM3ulist!.privacyPolicy!.privacyPolicy}");
                    },
                    child: const Text(
                      "https://privacypolicy.com",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Divider(),
                  const Text("Terms & Conditions"),
                  InkWell(splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      launch(
                          "${modelApi!.comBitlinksEnglishIptvM3ulist!.termsOfUse!.termsOfUse}");
                    },
                    child: const Text(
                      "https://termsandcondition.com",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Divider(),
                  const Text("Contact"),
                  InkWell(splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      launch(
                          "${modelApi!.comBitlinksEnglishIptvM3ulist!.feedbackSupport!.emailId}?subject=${modelApi!.comBitlinksEnglishIptvM3ulist!.feedbackSupport!.emailSubject}&body=${modelApi!.comBitlinksEnglishIptvM3ulist!.feedbackSupport!.emailMessage}");
                    },
                    child: Text(
                      "${modelApi!.comBitlinksEnglishIptvM3ulist!.feedbackSupport!.emailId}",
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            )
          ],
        );
      });
}