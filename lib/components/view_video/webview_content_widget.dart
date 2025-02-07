import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/network/network_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContentWidget extends StatefulWidget {
  final Uri uri;

  final bool autoPlayVideo;

  const WebViewContentWidget({
    required this.uri,
    this.autoPlayVideo = false,
  });

  @override
  State<WebViewContentWidget> createState() => _WebViewContentWidgetState();
}

class _WebViewContentWidgetState extends State<WebViewContentWidget> with AutomaticKeepAliveClientMixin {
  WebViewController? _webViewController;
  WebResourceError? error;
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    await _loadContent();
  }

  Future<void> _loadContent() async {
    final autoplayUri = widget.uri.replace(queryParameters: {
      ...widget.uri.queryParameters,
      'autoplay': '1', // Enable autoplay
      'muted': '1',
      'controls': '1', // Ensure all controls, including mute, are displayed// Optional: Mute the video for autoplay
    });

    _webViewController = WebViewController()
      ..setBackgroundColor(Colors.black)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              isLoading = progress < 100;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError e) {
            setState(() {
              isLoading = false;
              error = e;
            });
            if (e.errorCode == -2) {
              toast(language?.yourInterNetNotWorking);
            } else {
              toast(e.description);
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        widget.autoPlayVideo ? autoplayUri : widget.uri,
        headers: <String, String>{'Cache-Control': 'no-store'},
      );

    setState(() {});
  }

  @override
  void dispose() {
    _webViewController?.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: context.width(),
      height: context.height(),
      child: Stack(
        children: [
          if (_webViewController != null && error == null) WebViewWidget(controller: _webViewController!),
          if (error != null)
            NoDataWidget(
              titleTextStyle: secondaryTextStyle(color: white),
              subTitleTextStyle: primaryTextStyle(color: white),
              title: error?.errorCode == -2 ? language?.yourInterNetNotWorking : error?.description,
              retryText: language?.refresh,
              onRetry: () async {
                error = null;
                await init();
              },
            ).center(),
        ],
      ),
    );
  }
}