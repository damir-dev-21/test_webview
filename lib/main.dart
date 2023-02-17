import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_test/providers/connect_provider.dart';
import 'package:webview_test/screens/ConnectScreen.dart';
import 'package:webview_test/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseRemoteConfigService().initialize();

  final ConnectProvider connectProvider = ConnectProvider();
  await connectProvider.checkInitialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => connectProvider),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConnectScreen(),
    ),
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
