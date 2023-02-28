// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// class WebviewScreen extends StatefulWidget {
//   const WebviewScreen(this.urlWebview, {super.key});

//   static const String routeName = '/webview';

//   static Route route({required String urlWebview}) {
//     return MaterialPageRoute(
//         settings: const RouteSettings(name: routeName),
//         builder: (_) => WebviewScreen(urlWebview));
//   }

//   final String urlWebview;

//   @override
//   State<WebviewScreen> createState() => _WebviewScreenState();
// }

// class _WebviewScreenState extends State<WebviewScreen> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();

//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }

//     final WebViewController controller =
//         WebViewController.fromPlatformCreationParams(params);

//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('$progress % ');
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.urlWebview));
//     _controller = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (await _controller.canGoBack()) {
//           await _controller.goBack();
//         }
//         return false;
//       },
//       child: Scaffold(
//           body: SafeArea(child: WebViewWidget(controller: _controller))),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  WebviewScreen({super.key, required this.urlWebview});

  static const String routeName = '/webview';

  static Route route({required String urlWebview}) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => WebviewScreen(
              urlWebview: urlWebview,
            ));
  }

  final String urlWebview;

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  WebViewController? _controller;
  bool isl = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              if (await _controller!.canGoBack()) {
                _controller!.goBack();
              }
              return false;
            },
            child: WebView(
              initialUrl: widget.urlWebview,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
              gestureNavigationEnabled: true,
            ),
          );
        }),
      ),
    );
  }
}
