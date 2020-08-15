import 'package:flutter/material.dart';
import 'package:news_app/data/article.dart';
import 'package:news_app/services/news_api.dart';
import 'package:news_app/widgets/article_card.dart';

class NewsTab extends StatefulWidget {
  final String source;
  NewsTab({Key key, this.source}) : super(key: key);
  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  int totalResults;
  List<Article> articles;
  bool isError = false;
  String errorMessage = '';

  Future<void> loadArticles() =>
      NewsAPI().getTopHeadlinesFromSource(widget.source).then(
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
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
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
                    itemCount: totalResults,
                    itemBuilder: (BuildContext context, int index) =>
                        ArticleCard(articles[index]),
                  ),
          );
  }
}