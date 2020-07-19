import 'package:flutter/material.dart';
import 'package:news_app/news_api_sources.dart';
import 'package:news_app/news_tab.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'News App'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: newsApiSources.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: BackButton(),
        ),
        body: Column(
          children: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: TabBar(
                isScrollable: true,
                labelColor: Colors.black,
                tabs: newsApiSources
                    .map<Widget>((source) => Tab(
                          text: source['name'],
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: newsApiSources
                    .map<Widget>((source) => NewsTab(
                          source: source['source-id'],
                          key: PageStorageKey(source['source-id']),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

