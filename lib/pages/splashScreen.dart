import "package:flutter/material.dart";
import "../data/qurandb.dart";

class SplashScreen extends StatefulWidget{

  @override
  SplashScreenState createState() => new SplashScreenState();

}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
//    QuranDatabase.get().init().then((status){
//      print("cangcut ${status.toString()}");
//      navigationPage();
//    });
    QuranDatabase().init().then((status){
      navigationPage();
    });
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/homepage');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new Text("Ini Splash Screen")
        )
      )
    );
  }
}