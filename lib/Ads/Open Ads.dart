



import 'package:flutter/material.dart';
import 'package:google_applovin_unity_ads/google_applovin_unity_ads.dart';

import '../Globle/GetController.dart';

abstract class OpenAdState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print('stateeeeeeeeee=========$state');
    if (state == AppLifecycleState.resumed) {
      // print('resumeeeeeeeeeeeeeee=========AppLifecycleState.resumed');
      if(!ControllerGetX.to.isAdShow.value && !ControllerGetX.to.isRewardAdsShow.value && !ControllerGetX.to.isIntraAdsShow.value) {
        // print('controllerrrrrrrr========121212121212');
        GoogleApplovinUnityAds.showOpenAds(callback: () => {
          // print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'),
          ControllerGetX.to.isAdShow.value = true
        });
      }
    }

    if (state == AppLifecycleState.paused) {
      // print('stateeeeeeeeee=========9999999999999999999999999999');
      ControllerGetX.to.isAdShow.value = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

}