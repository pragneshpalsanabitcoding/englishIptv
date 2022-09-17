
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget blueGreenUnderstood(String title) {
  return Container(
    width: 8.w,
    height: 5.5.h,
    // margin: EdgeInsets.all(10),
    margin: EdgeInsets.only(left: 10.w, right: 10.w
        , bottom: 1.h, top: 1.h
    ),
    // padding: EdgeInsets.all(1.5.h),
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        color: Color(0xff36B149),
        borderRadius: BorderRadius.all(Radius.circular(14))),
    child: Center(
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget buttonRed(String title) {
  return Container(
    width: 70.w,
    height: 44.h,
    margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 20.h),
    // padding: EdgeInsets.all(1.5.h),
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        color: Color(0xffE20000),
        borderRadius: BorderRadius.all(Radius.circular(14))),
    child: Center(
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 20.w, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
Widget buttonsGrey(String title) {
  return Container(
    width: 70.w,
    height: 44.h,
    margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.h, top: 2.h),
    // padding: EdgeInsets.all(1.5.h),
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(14))),
    child: Center(
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 20.w, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget yellowWhite(String title) {
  return Container(
    width: 70.w,
    height: 44.h,
    margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        color: Color(0xff043BA7),
        borderRadius: BorderRadius.all(Radius.circular(14))),
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(title,
            textAlign: TextAlign.center,

            style: TextStyle(
                color: Colors.white,
                fontSize: 17.w,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 5.w,),
        const Text("(Ad)",style: TextStyle(color: Colors.white),)
      ],
    ),
  );
}


Widget buttonGrey(String title) {
  return Container(
    width: 70.w,
    height: 44.h,
    margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        color: Color(0xff32B5FF),
        borderRadius: BorderRadius.all(Radius.circular(14))),
    child: Center(
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 18.w, fontWeight: FontWeight.bold),
      ),
    ),
  );
}