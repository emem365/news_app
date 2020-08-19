import 'package:flutter/material.dart';
import 'package:news_app/src/controllers/news_notifier.dart';
import 'package:news_app/src/data/persistent_database.dart';
import 'package:news_app/src/data/service_locator.dart';
import 'package:news_app/src/widgets/dialog_box.dart';
import 'package:provider/provider.dart';

class ShowSelectedSources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsNotifier = Provider.of<NewsNotifier>(context);
    if (!newsNotifier.subscribedSourcesController.hasData)
      return Center(
          child: Text('Somethings wrong:(\nThis should not have happened'));
    List<PersistentSource> sources =
        newsNotifier.subscribedSourcesController.persistentSources;
    if (sources.length == 0)
      return Center(
        child: Text(
          'You have no selected sources. Add some!',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      );
    return ListView.builder(
        itemCount: sources.length,
        itemBuilder: (BuildContext context, int index) {
          return SwitchListTile(
              title: Text(sources[index].name),
              value: true,
              onChanged: (_) async {
                DialogOptions response = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogBox(
                        content: Text(
                          'Do you really want to delete? ',
                          textAlign: TextAlign.center,
                        ),
                        color: Theme.of(context).primaryColor,
                      );
                    });
                if (response == DialogOptions.approve) {
                  locator<PersistentDatabase>()
                      .deletePersistentSource(sources[index]);
                } else {
                  print('Aborted');
                }
              });
        });
  }
}
