import 'package:shared_preferences/shared_preferences.dart';

Future<String> checkUrl() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final localUrl = prefs.getString('url') ?? '';
  if (localUrl == '') {
    return localUrl;
  }
  return localUrl;
}

Future<void> setUrl(String url) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('url', url);
}
