import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/news_api.dart';
import 'package:news_app/data/persistent_database.dart';
import 'package:news_app/models/source.dart';

class SourcesPage extends StatefulWidget {
  @override
  _SourcesPageState createState() => _SourcesPageState();
}

class _SourcesPageState extends State<SourcesPage> {
  final PersistentDatabase _database = PersistentDatabase();
  bool showSelected = false;
  bool isLoading = true;
  BuiltList<Source> sources;
  bool isError = false;
  String errorMessage = '';

  Future<void> loadArticles() => NewsAPI.create().getSources().then((response) {
        if (mounted)
          setState(() {
            isLoading = false;
            isError = false;
            sources = response.body.sources;
          });
      }, onError: (error) {
        if (mounted)
          setState(() {
            isLoading = false;
            isError = true;
            errorMessage = '$error';
          });
      });

  @override
  void initState() {
    super.initState();
    loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (showSelected) {
          setState(() {
            showSelected = false;
          });
          return false;
        } else
          return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sources',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: BackButton(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              showSelected = !showSelected;
            });
          },
          label: showSelected ? Text('Show All') : Text('Show Selected'),
          icon: showSelected
              ? Icon(Icons.check_box_outline_blank)
              : Icon(Icons.check_box),
        ),
        body: StreamBuilder<List<PersistentSource>>(
          stream: _database.watchAllPersistentSources(),
          builder: (context, snapshot) {
            if (snapshot.hasData && showSelected) {
              if (snapshot.data.length == 0)
                return Center(
                  child: Text(
                    'You have no selected sources. Add some!',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                );
              else
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SwitchListTile(
                        title: Text(snapshot.data[index].name),
                        value: true,
                        onChanged: (_) {
                          _database
                              .deletePersistentSource(snapshot.data[index]);
                        },
                      );
                    });
            }
            if (!snapshot.hasData || isLoading)
              return Center(child: CircularProgressIndicator());
            else
              return RefreshIndicator(
                onRefresh: loadArticles,
                child: isError
                    ? ListView(
                        padding: EdgeInsets.only(top: 20),
                        children: [
                          Text(
                            'Error loading data.\nPlease check your internet connection!',
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: sources.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool isSelected = snapshot.data.contains(
                              persistentSourceFromSource(sources[index]));
                          return SwitchListTile(
                            title: Text(sources[index].name),
                            value: isSelected,
                            onChanged: (_) {
                              if (isSelected)
                                _database.deletePersistentSource(
                                    persistentSourceFromSource(sources[index]));
                              else
                                _database.insertPersistentSource(
                                    persistentSourceFromSource(sources[index]));
                            },
                          );
                        }),
              );
          },
        ),
      ),
    );
  }
}
