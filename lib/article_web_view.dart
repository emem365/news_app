import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatefulWidget {
  final String title;
  final String url;

  ArticleWebView({
    this.title,
    this.url,
  });

  @override
  _ArticleWebViewState createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  bool pageIsLoading = true;

  void onPageLoaded() => setState(() => pageIsLoading = false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: BackButton(),
      ),
      body: Column(
        children: <Widget>[
          if (pageIsLoading) LinearProgressIndicator(),
          Expanded(
            child: WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (_) => onPageLoaded(),
              ),
          ),
        ],
      ),
    );
  }
}
