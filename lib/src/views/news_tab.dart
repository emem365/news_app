import 'package:flutter/material.dart';
import 'package:news_app/src/controllers/news_tab_controller.dart';
import 'package:news_app/src/widgets/article_card.dart';
import 'package:provider/provider.dart';

class NewsTab extends StatelessWidget {
  NewsTab({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final controller= Provider.of<NewsTabController>(context);    
    return controller.isLoading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: controller.loadArticles,
            child: controller.isError
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
                    itemCount: controller.totalResults,
                    itemBuilder: (BuildContext context, int index) =>
                        ArticleCard(controller.articles[index]),
                  ),
          );
  }
}
