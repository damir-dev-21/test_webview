import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:webview_test/config/app_router.dart';
import 'package:webview_test/models/Diaries/Diaries.dart';
import 'package:webview_test/models/Diary/Diary.dart';
import 'package:webview_test/models/Task/Task.dart';
import 'package:webview_test/providers/connect_provider.dart';
import 'package:webview_test/providers/diary_provider.dart';
import 'package:webview_test/screens/ConnectScreen.dart';
import 'package:webview_test/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseRemoteConfigService().initialize();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(DiaryAdapter());
  Hive.registerAdapter(DiariesAdapter());
  await Hive.openBox<Diaries>('diaries');

  ConnectProvider connectProvider = ConnectProvider();
  DiaryProvider diaryProvider = DiaryProvider();

  await connectProvider.checkInitialize();
  await connectProvider.checkIsEmu();
  diaryProvider.getStatus();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => connectProvider),
      ChangeNotifierProvider(create: (_) => diaryProvider),
    ],
    // ignore: prefer_const_constructors
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Webview',
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: ConnectScreen.routeName,
    ),
  ));
}
