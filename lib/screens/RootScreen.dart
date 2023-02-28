import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_test/config/app_router.dart';
import 'package:webview_test/models/Diary/Diary.dart';
import 'package:webview_test/models/Task/Task.dart';
import 'package:webview_test/providers/connect_provider.dart';
import 'package:webview_test/providers/diary_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:webview_test/models/Diaries/Diaries.dart';
import 'package:webview_test/screens/ConnectScreen.dart';
import 'package:webview_test/services/firebase_service.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  ConnectProvider connectProvider = ConnectProvider();

  DiaryProvider diaryProvider = DiaryProvider();

  Future<void> initApp() async {
    await FirebaseRemoteConfigService().initialize();

    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(DiaryAdapter());
    Hive.registerAdapter(DiariesAdapter());
    await Hive.openBox<Diaries>('diaries');
    await connectProvider.checkInitialize();
    diaryProvider.getStatus();
  }

  @override
  void initState() async {
    await initApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => connectProvider),
        ChangeNotifierProvider(create: (_) => diaryProvider),
      ],
      // ignore: prefer_const_constructors
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nesine',
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: ConnectScreen.routeName,
      ),
    );
  }
}
