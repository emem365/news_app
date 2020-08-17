import 'package:flutter/material.dart';
import 'package:news_app/src/views/sources_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/appIcon-adaptive.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text(
                  'News App',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white70),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            title: Text('View News by region'),
            onTap: () {},
          ),
          ListTile(
            title: Text('View News by language'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Select your sources'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SourcesPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Text('ABOUT NEWS APP'),
            onTap: () {},
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Version: 1.1'),
          ),
        ],
      ),
    );
  }
}
