import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_test/services/firebase_service.dart';
import 'package:webview_test/services/local_database.dart';

class ConnectProvider extends ChangeNotifier {
  bool isConnect = false;
  bool isUrl = false;
  bool isEmul = false;
  String urlWebview = '';
  String errorFRC = '';

  Future<void> checkInitialize() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    FirebaseRemoteConfigService remoteConfig = FirebaseRemoteConfigService();
    var url = pref.getString('url');
    if (url != null) {
      urlWebview = url;
      isUrl = true;
      await checkConnection();
    } else {
      try {
        isEmul = await checkIsEmu();
        if (remoteConfig.urlFromFirebase != "" && isEmul == false) {
          await setUrl(remoteConfig.urlFromFirebase);
          urlWebview = pref.getString('url')!;
        } else {
          urlWebview = "";
        }
      } catch (e) {
        errorFRC = e.toString();
        throw e;
      }
    }
    notifyListeners();
  }

  void changeConnect(String status) {
    if (status == 'none') {
      isConnect = false;
      notifyListeners();
    } else {
      isConnect = true;
      notifyListeners();
    }
  }

  Future<void> checkConnection() async {
    var connect = await (Connectivity().checkConnectivity());
    if (connect == ConnectivityResult.none) {
      changeConnect('none');
      notifyListeners();
    } else if (connect == ConnectivityResult.mobile) {
      changeConnect('mobile');
    } else if (connect == ConnectivityResult.wifi) {
      changeConnect('wifi');
    }
    notifyListeners();
  }

  checkIsEmu() async {
    var devinfo = DeviceInfoPlugin();
    final em = await devinfo.androidInfo;
    var phoneModel = em.model;
    var buildProduct = em.product;
    var buildHardware = em.hardware;
    var result = (em.fingerprint.startsWith("generic") ||
        phoneModel.contains("google_sdk") ||
        phoneModel.contains("droid4x") ||
        phoneModel.contains("Emulator") ||
        phoneModel.contains("Android SDK built for x86") ||
        em.manufacturer.contains("Genymotion") ||
        buildHardware == "goldfish" ||
        buildHardware == "vbox86" ||
        buildProduct == "sdk" ||
        buildProduct == "google_sdk" ||
        buildProduct == "sdk_x86" ||
        buildProduct == "vbox86p" ||
        em.brand.contains('google') ||
        em.board.toLowerCase().contains("nox") ||
        em.bootloader.toLowerCase().contains("nox") ||
        buildHardware.toLowerCase().contains("nox") ||
        !em.isPhysicalDevice ||
        buildProduct.toLowerCase().contains("nox"));

    if (result) return true;
    result = result ||
        (em.brand.startsWith("generic") && em.device.startsWith("generic"));
    if (result) return true;
    result = result || ("google_sdk" == buildProduct);
    return result;
  }
}
