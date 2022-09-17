import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Get Start Screen.dart';
import 'Globle/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getBool("aggrement");
    if (value == true) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.off(const GetStartScreen());
      });
    } else {
      showDialogPop();
    }
  }

  showDialogPop() async {
    await Future.delayed(const Duration(seconds: 1));
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (aa) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.h))),
              actions: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: themeButtonColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.h),
                          topRight: Radius.circular(30.h))),
                  height: 40.h,
                  child: Text(
                    "Agreement",
                    style: TextStyle(color: Colors.white, fontSize: 20.w),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                          padding: EdgeInsets.all(10.h),
                          child: const Text(
                            "Before you download please read carefully we are not providing TV Channel and it’s not TV channel app and this app gives you channel URL or File and QR code also",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () async {
                          Get.back();
                          SharedPreferences pref =
                          await SharedPreferences.getInstance();

                          pref.setBool("aggrement", true);

                          Future.delayed(const Duration(seconds: 2), () {
                            Get.off(const GetStartScreen());
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100.w,
                          padding: EdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                              color: themeButtonColor),
                          child: Text(
                            "Accept",
                            style:
                            TextStyle(color: Colors.white, fontSize: 16.w),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          exit(0);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100.w,
                          padding: EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(14))),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red, fontSize: 16.w),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          child: Image.asset('images/new/splash1.png', fit: BoxFit.fill)),
    );
  }
}