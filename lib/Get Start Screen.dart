
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Ads/Ads File.dart';
import 'Globle/Dialogs.dart';
import 'Globle/const.dart';
import 'Open Channel Screen.dart';

class GetStartScreen extends StatefulWidget {
  const GetStartScreen({Key? key}) : super(key: key);

  @override
  State<GetStartScreen> createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      return false;
    },
      child: Scaffold(
        backgroundColor: themColor,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  child: Text('Free Download IPTV',
                      style: TextStyle(fontSize: 20.h, color: Colors.white))),
              Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Image.asset('images/new/EnglishGroup.png'),
              ),
              const SizedBox(),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  isFullAdss(
                      callback: () => {Get.offAll(const OpenChannelScreen())});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 45.h,
                  width: 150.w,
                  padding: EdgeInsets.all(1.5.h),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: downloadFileColor),
                  child: Text(
                    "Get Start",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.w,
                    ),
                  ),
                ),
              ),
              const SizedBox(),
            ]),
      ),
    );
  }

  @override
  void initState() {
    updateDialoug();
  }
}
