import 'package:flutter/material.dart';
import 'package:news_app/src/controllers/news_notifier.dart';
import 'package:news_app/src/util/news_search.dart';
import 'package:news_app/src/views/news_tab.dart';
import 'package:news_app/src/views/sources_page.dart';
import 'package:news_app/src/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final newsNotifier = Provider.of<NewsNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: NewsSearch(),
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: newsNotifier.isLoading
            ? Center(
                child: Text(
                    'Something looks wrong :(\nThis should not have happened.'),
              )
            : (newsNotifier.newsTabs.length == 0)
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Please subscribe to some sources to begin :)'),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SourcesPage()));
                            },
                            child: Text('View Sources'),
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : DefaultTabController(
                    length: newsNotifier.newsTabs.length,
                    child: Column(
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(30),
                          child: TabBar(
                            isScrollable: true,
                            labelColor: Colors.black,
                            tabs: newsNotifier.newsTabs
                                .map<Widget>((newsTabController) => Tab(
                                      text: newsTabController.source.name,
                                    ))
                                .toList(),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: newsNotifier.newsTabs
                                .map<Widget>(
                                  (newsTabController) =>
                                      ChangeNotifierProvider.value(
                                          value: newsTabController,
                                          child: NewsTab(
                                            key: PageStorageKey(
                                                newsTabController.source.id),
                                          )),
                                )
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  ));
  }
}