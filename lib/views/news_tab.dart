import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/article.dart';
import 'package:news_app/views/article_web_view.dart';
import 'package:news_app/services/news_api.dart';
import 'package:intl/intl.dart';

final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

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
                        _buildArticleCard(articles[index]),
                  ),
          );
  }

  Widget _buildPublishedAtRow(DateTime datetime) => Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Date : ${_dateFormat.format(datetime)}',
              softWrap: true,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            child: Text(
              'Time : ${datetime.hour}:${datetime.minute} ${datetime.timeZoneName}',
              softWrap: true,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      );
  Widget _buildArticleCard(Article article) => Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 5,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    ArticleWebView(title: article.title, url: article.url),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(minHeight: 150),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: article.urlToImage,
                    progressIndicatorBuilder: (context, _, downloadProgress) =>
                        Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                    errorWidget: (context, _, __) =>
                        Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  '\"${article.title}\"',
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 20, color: Colors.black),
                ),
              ),
              if (article.description != '')
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text(
                    article.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: _buildPublishedAtRow(article.publishedAt),
              ),
            ],
          ),
        ),
      );
}
