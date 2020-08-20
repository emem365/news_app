import 'package:flutter/material.dart';
import 'package:news_app/src/data/news_api.dart';
import 'package:news_app/src/data/service_locator.dart';
import 'package:news_app/src/models/article.dart';
import 'package:news_app/src/models/headlines_response.dart';
import 'package:news_app/src/widgets/article_card.dart';
import 'package:chopper/chopper.dart';

class NewsSearch extends SearchDelegate {
  final _api = locator<NewsAPI>();
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
    if (query == '') return Center(child: Text('Enter keyword'));
    return FutureBuilder<List<Article>>(
      future: getResults(),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        if (snapshot.data.length == 0)
          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No results found!',
              ),
            ),
          );
        final results = snapshot.data
            .map<Widget>(
              (article) => ArticleCard(article),
            )
            .toList();
        return ListView(
          children: results,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '') return Center(child: Text('Enter keyword'));
    return FutureBuilder<List<Article>>(
      future: getSuggestions(),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        if (snapshot.data.length == 0)
          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No results found!',
              ),
            ),
          );
        final results = snapshot.data
            .map<Widget>(
              (article) => ListTile(
                title: Text(article.title),
                onTap: () {
                  query = article.title;
                  showResults(context);
                },
              ),
            )
            .toList();
        results.add(
          Align(
            alignment: Alignment.topCenter,
            child: FlatButton(
              child: Text('See results'),
              onPressed: () => showResults(context),
            ),
          ),
        );
        return ListView(
          children: results,
        );
      },
    );
  }

  Future<List<Article>> getSuggestions() async {
    try {
      Response<HeadlinesResponse> response =
          await _api.getEverything(query: query, pageSize: 5);
      if (response.statusCode == 200) return List.from(response.body.articles);
      return Future.error(response.statusCode);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Article>> getResults() async {
    try {
      Response<HeadlinesResponse> response =
          await _api.getEverything(query: query, pageSize: 10);
      if (response.statusCode == 200) return List.from(response.body.articles);
      return Future.error(response.statusCode);
    } catch (e) {
      return Future.error(e);
    }
  }
}
