import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/date_format.dart';
import 'package:news_app/src/models/article.dart';
import 'package:news_app/src/views/article_web_view.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  ArticleCard(this.article);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            if (article.urlToImage != null && article.urlToImage != "" && article.urlToImage!='null')
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
            if (article.description != null && article.description != '')
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
              child: _buildPublishedAtRow(Theme.of(context).textTheme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPublishedAtRow(TextTheme _textTheme) {
    DateTime dateTime = DateTime.parse(article.publishedAt).toLocal();
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Date : ${dateFormat.format(dateTime)}',
            softWrap: true,
            style: _textTheme.subtitle1,
          ),
        ),
        Expanded(
          child: Text(
            'Time : ${dateTime.hour}:${dateTime.minute} ${dateTime.timeZoneName}',
            softWrap: true,
            style: _textTheme.subtitle1,
          ),
        ),
      ],
    );
  }
}
