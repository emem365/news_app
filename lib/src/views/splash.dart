import 'package:flutter/material.dart';
import 'package:news_app/src/controllers/about_data.dart';
import 'package:news_app/src/controllers/news_notifier.dart';
import 'package:news_app/src/views/home_page.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isWaiting = true;

  Future<void> delay() async {
    await Future.delayed(Duration(seconds: 2));
  }

  pushIfReady() {
    delay().then((value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(title: AboutData.appName),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsNotifier = Provider.of<NewsNotifier>(context);

    if(!newsNotifier.isLoading)
    pushIfReady();
    return Material(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          SizedBox(height: 200),
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
          SizedBox(height: 200),
          JumpingDotsProgressIndicator(
              fontSize: 36,
              color: Colors.white70,
            ),
        ],
      ),
    );
  }
}
