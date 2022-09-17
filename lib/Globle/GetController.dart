



import 'package:get/get.dart';

class ControllerGetX extends GetxController {
  static ControllerGetX to = ControllerGetX();
  var count = 0;
  RxBool lottistatus = false.obs;
  RxInt versionCode = 1.obs;
  RxBool isAdShow = false.obs;
  RxBool isRewardAdsShow= false.obs;
  RxBool isIntraAdsShow= false.obs;
}
