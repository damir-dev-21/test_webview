import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_test/providers/connect_provider.dart';

class NetworkScreen extends StatefulWidget {
  NetworkScreen({Key? key}) : super(key: key);

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            ? const CircularProgressIndicator()
            : const Text('Необходим доступ к сети'),
      ),
    );
  }
}
