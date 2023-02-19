import 'package:flutter/material.dart';
import 'package:webview_test/models/Task/Task.dart';
import 'package:webview_test/screens/ChokeScreen.dart';
import 'package:webview_test/screens/ConnectScreen.dart';
import 'package:webview_test/screens/DiaryScreen.dart';
import 'package:webview_test/screens/ErrorScreen.dart';
import 'package:webview_test/screens/NetworkScreen.dart';
import 'package:webview_test/screens/TaskScreen.dart';
import 'package:webview_test/screens/TasksScreen.dart';
import 'package:webview_test/screens/WebviewScreen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This is route: ${settings.name}');

    switch (settings.name) {
      case ConnectScreen.routeName:
        return ConnectScreen.route();
      case WebviewScreen.routeName:
        return WebviewScreen.route(urlWebview: settings.arguments as String);
      case NetworkScreen.routeName:
        return NetworkScreen.route();
      case ErrorScreen.routeName:
        return ErrorScreen.route();
      case Home.routeName:
        return Home.route(idx: settings.arguments as int);
      case DiaryList.routeName:
        return DiaryList.route();
      case TasksList.routeName:
        return TasksList.route(tasks: settings.arguments as List<Task>);
      case TaskScreen.routeName:
        return TaskScreen.route(task: settings.arguments as Task);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
            ));
  }
}
