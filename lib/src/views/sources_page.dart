import 'package:flutter/material.dart';
import 'package:news_app/src/controllers/news_notifier.dart';
import 'package:news_app/src/controllers/sources_page_controller.dart';
import 'package:news_app/src/data/persistent_database.dart';
import 'package:news_app/src/data/service_locator.dart';
import 'package:news_app/src/views/show_subscribed_sources.dart';
import 'package:provider/provider.dart';

class SourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SourcesPageController>(context);
    final newsNotifier = Provider.of<NewsNotifier>(context);
    final _database = locator<PersistentDatabase>();
    return WillPopScope(
      onWillPop: () async {
        if (controller.showSubscribed) {
          controller.toggleShowSubscribed();
          return false;
        } else
          return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            controller.showSubscribed ? 'Sources' : 'Subscribed Sources',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: BackButton(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: controller.toggleShowSubscribed,
          label: controller.showSubscribed
              ? Text('Show All')
              : Text('Show Subscribed'),
          icon: controller.showSubscribed
              ? Icon(Icons.check_box_outline_blank)
              : Icon(Icons.check_box),
        ),
        body: controller.showSubscribed
            ? ShowSubscribedSources()
            : controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: controller.loadSources,
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
                            itemCount: controller.sources.length,
                            itemBuilder: (BuildContext context, int index) {
                              bool isSubscribed = newsNotifier
                                  .subscribedSourcesController.persistentSources
                                  .contains(persistentSourceFromSource(
                                      controller.sources[index]));
                              return SwitchListTile(
                                title: Text(controller.sources[index].name),
                                value: isSubscribed,
                                onChanged: (_) {
                                  if (isSubscribed)
                                    _database.deletePersistentSource(
                                        persistentSourceFromSource(
                                            controller.sources[index]));
                                  else
                                    _database.insertPersistentSource(
                                        persistentSourceFromSource(
                                            controller.sources[index]));
                                },
                              );
                            }),
                  ),
      ),
    );
  }
}
