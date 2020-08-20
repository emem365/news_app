import 'package:flutter/material.dart';
import 'package:news_app/src/controllers/news_notifier.dart';
import 'package:news_app/src/controllers/sources_page_controller.dart';
import 'package:news_app/src/data/persistent_database.dart';
import 'package:news_app/src/data/service_locator.dart';
import 'package:provider/provider.dart';

class SourcesSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    final sources = Provider.of<SourcesPageController>(context).sources;
    final subscribedSources = Provider.of<NewsNotifier>(context)
        .subscribedSourcesController
        .persistentSources;
    final _database = locator<PersistentDatabase>();
    if (query == '') return Center(child: Text('Enter keyword'));
    List results = sources
        .where((element) => element.name.contains(query))
        .toList();
    if (results.length == 0)
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'No results found!',
          ),
        ),
      );
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          bool isSubscribed = subscribedSources
              .contains(persistentSourceFromSource(results[index]));
          return SwitchListTile(
            title: Text(results[index].name),
            value: isSubscribed,
            onChanged: (_) {
              if (isSubscribed)
                _database.deletePersistentSource(
                    persistentSourceFromSource(results[index]));
              else
                _database.insertPersistentSource(
                    persistentSourceFromSource(results[index]));
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final sources = Provider.of<SourcesPageController>(context).sources;
    if (query == '') return Center(child: Text('Enter keyword'));
    List results = sources
        .where((element) => element.name.contains(query))
        .map<Widget>(
          (source) => ListTile(
            title: Text(source.name),
            onTap: () {
              query = source.name;
              showResults(context);
            },
          ),
        )
        .toList();
    if (results.length == 0)
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'No results found!',
          ),
        ),
      );
    if (results.length > 5) results = results.sublist(0, 5);
    results.add(Align(
      alignment: Alignment.topCenter,
      child: FlatButton(
        child: Text('See results'),
        onPressed: () => showResults(context),
      ),
    ));
    return ListView(
      children: results,
    );
  }
}
