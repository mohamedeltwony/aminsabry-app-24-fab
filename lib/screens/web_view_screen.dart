import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/components/loader_widget.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:webview_flutter/webview_flutter.dart' as web_view;
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  WebViewScreen({required this.url, required this.title});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  Completer<web_view.WebViewController> webCont = Completer<web_view.WebViewController>();

  WebViewController _webViewController = WebViewController();

  bool fetchingFile = true;
  bool? orderDone;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (msg) {},
      )
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {
          if (progress == 100) appStore.setLoading(false);
        },
        onPageStarted: (url) {
          appStore.setLoading(false);
        },
        onPageFinished: (url) {
          appStore.setLoading(false);
        },
        onNavigationRequest: (request) {
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(
        Uri.parse(widget.url),
        headers: {"Authorization": "Bearer ${getStringAsync(TOKEN)}", 'streamit-webview': "true"},
      );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        centerTitle: true,
        title: Text(widget.title.validate(), style: boldTextStyle()),
      ),
      body: Stack(
        children: [
          web_view.WebViewWidget(
            controller: _webViewController,
          ),
          Observer(builder: (_) => LoaderWidget().center().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
