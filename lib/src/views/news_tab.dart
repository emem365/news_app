import 'package:flutter/material.dart';
import 'package:news_app/src/controllers/news_tab_controller.dart';
import 'package:news_app/src/widgets/article_card.dart';
import 'package:provider/provider.dart';

class NewsTab extends StatelessWidget {
  NewsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final controller = Provider.of<NewsTabController>(context);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        controller.loadArticles();
      }
    });

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
                  controller: scrollController,
                    itemCount: controller.articles.length+1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == controller.totalResults)
                        return Center(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('You\'re all caught up today')),
                        );
                      if (index == controller.articles.length)
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      return ArticleCard(controller.articles[index]);
                    }),
          );
  }
}
