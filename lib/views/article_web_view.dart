import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
        actions: [
          PopupMenuButton(
            onSelected: (String value) async {
              if (value == 'OPEN_IN_BROWSER')
                try {
                  await _launchURL(widget.url);
                } catch (e) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'OPEN_IN_BROWSER',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.open_in_browser),
                    Text('Open in Browser'),
                  ],
                ),
              ),
            ],
          ),
        ],
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

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
