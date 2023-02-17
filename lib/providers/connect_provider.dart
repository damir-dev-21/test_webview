import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_test/services/firebase_service.dart';
import 'package:webview_test/services/local_database.dart';

class ConnectProvider extends ChangeNotifier {
  bool isConnect = false;
  bool isUrl = false;
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
        if (remoteConfig.urlFromFirebase != "") {
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
}
