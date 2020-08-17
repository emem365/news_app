import 'package:flutter/material.dart';
import 'package:news_app/data/persistent_database.dart';
import 'package:news_app/data/service_locator.dart';

class ShowSelectedSources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: locator<PersistentDatabase>().watchAllPersistentSources(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        if (snapshot.data.length == 0)
          return Center(
            child: Text(
              'You have no selected sources. Add some!',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          );
        else
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return SwitchListTile(
                  title: Text(snapshot.data[index].name),
                  value: true,
                  onChanged: (_) {
                    locator<PersistentDatabase>()
                        .deletePersistentSource(snapshot.data[index]);
                  },
                );
              });
      },
    );
  }
}
