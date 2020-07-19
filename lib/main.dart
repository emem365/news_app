import 'package:flutter/material.dart';
import 'package:news_app/api_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
      home: MyHomePage(title: 'News App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  int totalResults;
  List<Article> articles;
  bool isError = false;
  String errorMessage = '';

  Future<void> loadArticles() =>
    NewsAPI().getTopHeadlinesFromSource('bbc-news').then(
        (response) => setState(() {
              
              isLoading = false;
              isError = false;
              totalResults = response.totalResults;
              articles = response.articles;
            }),
        onError: (error) => setState(() {
              isLoading = false;
              isError = true;
              errorMessage = '$error';
            }));

  @override
  void initState() {
    super.initState();
    loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadArticles,
              child: isError ? ListView(children: [Text('Error')],): ListView.builder(
                  itemCount: totalResults,
                  itemBuilder: (BuildContext context, int index) =>
                      Text(articles[index].toString())),
            ),
    );
  }
}

class NewsAPI {
  String url = "https://newsapi.org/v2";
  Response parseResponse(var response) {
    Map jsonResponse = convert.jsonDecode(response.body);
    return Response.fromJson(jsonResponse);
  }

  Future<Response> getTopHeadlinesFromSource(String source) async {
    String requestURL = "$url/top-headlines?sources=$source&apiKey=b8fb99a230f343a78ebf79b5e3243f7f";
    var response = await http.get(requestURL);
    if (response.statusCode != 200) {
      return Future.error(response.statusCode);
    }
    return parseResponse(response);
  }
}

class Response {
  String status;
  int totalResults;
  List<Article> articles;

  Response({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory Response.fromJson(Map json) => Response(
        status: json['status'] ?? '',
        totalResults: json['totalResults'] ?? 0,
        articles: json['articles']
                .map<Article>(
                    (jsonArticleObject) => Article.fromJson(jsonArticleObject))
                .toList() ??
            <Article>[],
      );
}

class Article {
  String sourceID;
  String sourceName;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  Article({
    this.sourceID,
    this.sourceName,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map json) => Article(
        sourceID: json['source']['id'] ?? '[\'null\']',
        sourceName: json['source']['name'] ?? '[\'null\']',
        author: json['author'] ?? '[\'null\']',
        title: json['title'] ?? '[\'null\']',
        description: json['description'] ?? '[\'null\']',
        url: json['url'] ?? '[\'null\']',
        urlToImage: json['urlToImage'] ?? '[\'null\']',
        publishedAt: DateTime.parse(json['publishedAt']) ?? null,
        content: json['content'] ?? '[\'null\']',
      );

  String toString() {
    return 'Article($title, $sourceName, $publishedAt)';
  }
}
