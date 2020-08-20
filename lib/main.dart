import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/src/controllers/news_notifier.dart';
import 'package:news_app/src/controllers/sources_page_controller.dart';
import 'package:news_app/src/data/service_locator.dart';
import 'package:news_app/src/views/splash.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsNotifier>(create: (_)=>NewsNotifier(),),
        ChangeNotifierProvider<SourcesPageController>(create: (_)=>SourcesPageController(),),
      ],
      child: MaterialApp(
        title: 'News',
        theme: ThemeData(
          primaryColor: Color(0xFFFF5E5B),
          cardColor: Color(0xFFEFEFEF),
          indicatorColor: Color(0xFF3454D1),
          buttonColor: Color(0xFF3454D1),
          accentColor: Color(0xFF3454D1),
          appBarTheme: AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
        ),
        home: Splash(),
      ),
    );
  }
}
