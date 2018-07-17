import "package:flutter/material.dart";
import "data/qurandb.dart";
import "pages/splashScreen.dart";
import "pages/homepageScreen.dart";
import "pages/quranreadScreen.dart";

void main() => runApp( new MyApp() );

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Hafiz Companion',
      theme: new ThemeData(
        primaryColor: Colors.teal
      ),
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => HomePage(),
        '/read'    : (BuildContext context) => QuranReadScreen()
      }
    );
  }

}
