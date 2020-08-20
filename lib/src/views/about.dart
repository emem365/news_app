import 'package:flutter/material.dart';
import 'package:news_app/src/controllers/about_data.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: BackButton(color: Colors.white70),
      //   backgroundColor: Theme.of(context).primaryColor,
      //   elevation: 0,
      // ),
      body: Stack(
        children: [
          Material(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Image.asset(
                    AboutData.logoAsset,
                    fit: BoxFit.fitHeight,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  AboutData.appName,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white70),
                ),
                SizedBox(
                  height: 25,
                ),
                ...AboutData.content
                    .map<Widget>((content) => _buildContent(context, content)),
                SizedBox(
                  height: 50,
                ),
                ...AboutData.aboutLinks
                    .map<Widget>((link) => _buildUrlRow(context, link)),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.topLeft, child:BackButton(color: Colors.white70),),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, String text) => Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          text,
          textAlign: TextAlign.justify,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white70),
        ),
      );
  Widget _buildUrlRow(BuildContext context, AboutLink link) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              '${link.category}:',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white70),
            ),
            Spacer(),
            FlatButton(
              child: Text(
                link.text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white70),
              ),
              onPressed: () => _launchURL(link.url),
            ),
          ],
        ),
      );
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
