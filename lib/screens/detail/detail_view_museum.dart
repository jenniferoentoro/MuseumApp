import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewMuseum extends StatefulWidget {
  final String title;
  final String museumUrl;

  const ViewMuseum({Key? key, required this.title, required this.museumUrl})
      : super(key: key);

  @override
  State<ViewMuseum> createState() => _ViewMuseumState();
}

class _ViewMuseumState extends State<ViewMuseum> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse(widget.museumUrl);

    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          backgroundColor: const Color(0xFF89B0AE),
        ),
        body: WebView(
          initialUrl: widget.museumUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    } else {
      launchUrl(_url);
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          backgroundColor: const Color(0xFF89B0AE),
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }
}
