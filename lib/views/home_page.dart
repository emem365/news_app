import 'package:flutter/material.dart';
import 'package:news_app/controllers/news_tab_controller.dart';
import 'package:news_app/data/persistent_database.dart';
import 'package:news_app/data/service_locator.dart';
import 'package:news_app/views/news_tab.dart';
import 'package:news_app/views/sources_page.dart';
import 'package:news_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final _persistentDatabase = locator<PersistentDatabase>();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: StreamBuilder<List<PersistentSource>>(
          stream: _persistentDatabase.watchAllPersistentSources(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              List<NewsTabController> _controllers = snapshot.data
                  .map((source) => NewsTabController(source))
                  .toList();
              if (_controllers.length == 0)
                return Center(
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
                );

              return DefaultTabController(
                length: _controllers.length,
                child: Column(
                  children: <Widget>[
                    PreferredSize(
                      preferredSize: Size.fromHeight(30),
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.black,
                        tabs: _controllers
                            .map<Widget>((newsTabController) => Tab(
                                  text: newsTabController.source.name,
                                ))
                            .toList(),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: _controllers
                            .map<Widget>((newsTabController) => ChangeNotifierProvider.value(value: newsTabController,child: NewsTab(
                                  key: PageStorageKey(
                                      newsTabController.source.id),
                                )),)
                            .toList(),
                      ),
                    )
                  ],
                ),
              );
            } else
              return LinearProgressIndicator();
          }),
    );
  }
}
