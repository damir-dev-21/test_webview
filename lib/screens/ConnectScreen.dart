import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_test/providers/connect_provider.dart';
import 'package:webview_test/screens/ChokeScreen.dart';
import 'package:webview_test/screens/ErrorScreen.dart';
import 'package:webview_test/screens/NetworkScreen.dart';
import 'package:webview_test/screens/WebviewScreen.dart';
import 'package:webview_test/services/firebase_service.dart';

class ConnectScreen extends StatefulWidget {
  ConnectScreen({Key? key}) : super(key: key);

  static const String routeName = '/connect';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => ConnectScreen());
  }

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  late String statusUrl;
  final remoteConfig = FirebaseRemoteConfigService();

  @override
  Widget build(BuildContext context) {
    ConnectProvider connectProvider = Provider.of<ConnectProvider>(context);
    if (connectProvider.isUrl && connectProvider.isConnect == false) {
      return NetworkScreen();
    } else if (connectProvider.urlWebview == '' || connectProvider.isEmul) {
      return const Home(
        idx: 0,
      );
    } else if (connectProvider.urlWebview != '') {
      return WebviewScreen(connectProvider.urlWebview);
    }
    return ErrorScreen();
  }
}
