import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_test/providers/connect_provider.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);
  static const String routeName = '/error';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => ErrorScreen());
  }

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
        centerTitle: true,
        leading: const SizedBox(),
        actions: [
          IconButton(
              onPressed: () {
                try {
                  setState(() {
                    isLoad = true;
                  });
                  context.read<ConnectProvider>().checkInitialize();
                } catch (e) {}
                setState(() {
                  isLoad = false;
                });
              },
              icon: const Icon(Icons.sync))
        ],
      ),
      body: Center(
        child: isLoad
            ? CircularProgressIndicator()
            : Text('Something will happened!'),
      ),
    );
  }
}
