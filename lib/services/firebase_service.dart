import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigService {
  static const String urlKey = 'url';
  FirebaseRemoteConfigService._()
      : _remoteConfig = FirebaseRemoteConfig.instance;

  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig;
  String getString(String key) => _remoteConfig.getString(key);

  String get urlFromFirebase => _remoteConfig.getString(urlKey);

  Future<void> _setConfSettings() async =>
      _remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 1)));

  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  Future<void> initialize() async {
    try {
      await _setConfSettings();
      await _remoteConfig.fetchAndActivate();
      print('url key: ' + _remoteConfig.getString(urlKey));
    } catch (e) {
      print(e);
    }
  }
}


// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';

// Future<FirebaseRemoteConfig> setupRemoteConfig() async {
//   await Firebase.initializeApp();
//   final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
//   await remoteConfig.setConfigSettings(RemoteConfigSettings(
//     fetchTimeout: const Duration(seconds: 10),
//     minimumFetchInterval: const Duration(hours: 1),
//   ));
//   // await remoteConfig.setDefaults(<String, dynamic>{
//   //   'welcome': 'default welcome',
//   //   'hello': 'default hello',
//   // });

//   final url_key = remoteConfig.getString("url");
//   print('url_key :' + url_key);
//   RemoteConfigValue(null, ValueSource.valueStatic);
//   return remoteConfig;
// }
