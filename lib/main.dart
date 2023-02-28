import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:webview_test/screens/RootScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(RootScreen());
}
