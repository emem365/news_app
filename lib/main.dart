import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/views/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: ThemeData(
        primaryColor: Color(0xFFFF5E5B),
        cardColor: Color(0xFFEFEFEF),
        indicatorColor: Color(0xFF3454D1),
        accentColor: Color(0xFF3454D1),
        appBarTheme: AppBarTheme(elevation: 0),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
      ),
      home: HomePage(title: 'News App'),
    );
  }
}
