import 'package:flutter/material.dart';
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
          builder: (context) => HomePage(title: 'News App'),
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'NewsApp',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 150,
          ),
          JumpingDotsProgressIndicator(
            fontSize: 48,
            color: Colors.white70,
          ),
          SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}
