



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_applovin_unity_ads/google_applovin_unity_ads.dart';
import 'package:google_applovin_unity_ads/native/controller.dart';

import '../Globle/GetController.dart';
import '../main.dart';

showIntraAds({Function? callback}) async {
  ControllerGetX.to.isAdShow.value=true;
  if (modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.appVersionCode == ControllerGetX.to.versionCode.value) {
    if (callback != null) {
      callback();
    }
  } else {
    GoogleApplovinUnityAds.showIntraAds(callback: callback);
  }
}

Future<void> showRewardAds({Function? callback}) async {
  ControllerGetX.to.isAdShow.value=true;
  if (modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.appVersionCode == ControllerGetX.to.versionCode.value) {
    if (callback != null) {
      callback();
    }
  } else {
    GoogleApplovinUnityAds.showRewardAds(callback: callback);
  }
}

bannerAds() {
  if (modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.appVersionCode == ControllerGetX.to.versionCode.value ||
      modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence!.isEmpty) {
    return Container(
      height: 0,
    );
  }

  return GoogleApplovinUnityAds.bannerAds();
}

fullNativeAds() {
  if (modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.appVersionCode == ControllerGetX.to.versionCode.value ||
      modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence!.isEmpty ||
      (modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence!.length == 1 &&
          modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence![0] == "custom_ads")) {
    return Container(
      height: 0,
    );
  }
  return GoogleApplovinUnityAds.nativeAds(
      NativeSize(Size(double.infinity, 50.h)), "F",
      error: Container(
        height: 0,
      ));
}

mediumNativeAds() {
  if (modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.appVersionCode == ControllerGetX.to.versionCode.value ||
      modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence!.isEmpty ||
      (modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence!.length == 1 &&
          modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence![0] == "custom_ads")) {
    return Container(
      height: 0,
    );
  }
  return GoogleApplovinUnityAds.nativeAds(
      NativeSize(Size(double.infinity, 150.h)), "M");
}

showOpenAd() {
  if (modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.appVersionCode == ControllerGetX.to.versionCode.value ||
      modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence!.isEmpty) {
    return;
  }

  GoogleApplovinUnityAds.showOpenAds();
}

smallNativeAds() {
  if (modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.appVersionCode == ControllerGetX.to.versionCode.value ||
      modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence!.isEmpty ||
      (modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence!.length == 1 &&
          modelApi!.comBitlinksEnglishIptvM3ulist!.adsSequence![0] == "custom_ads")) {
    return Container(
      height: 0,
    );
  }
  return GoogleApplovinUnityAds.nativeAds(
      NativeSize(Size(double.infinity, 50.h)), "S");
}

isFullAdss({Function? callback}){
  if(modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.isFullAds==true){
  showIntraAds(callback: callback);}
  else{
    if(callback!= null){
      callback();
    }
  }
}

isFullAdssNative(){
  return modelApi!.comBitlinksEnglishIptvM3ulist!.adSetting!.isFullAds==true?
  mediumNativeAds():Container();
}