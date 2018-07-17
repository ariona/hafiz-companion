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
        '/activity': (BuildContext context) => ActivityScreen(),
        '/read'    : (BuildContext context) => QuranReadScreen()
      }
    );
  }

}

class ActivityScreen extends StatefulWidget{
  @override
  ActivityScreenState createState() => new ActivityScreenState();
}

class ActivityScreenState extends State<ActivityScreen> with SingleTickerProviderStateMixin {
  TabController _controller;

  List _surah = new List();

  @override
  void initState() {

    super.initState();

    _controller = new TabController(length: 4, vsync: this);

    QuranDatabase().getAyahsRange(1, 1, 7)
      .then( (data){
        if (data==null) return;
        setState(() {
          _surah = data;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Container(
          padding: EdgeInsets.only(top:8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(bottom: 3.0,top:3.0),
                child: Text("Al-Baqarah", style: TextStyle(fontSize: 18.0 )),
              ),
              new Text("Ayah 20-25", style: TextStyle(fontSize:12.0,fontWeight: FontWeight.w300))
            ],
          ),
        ),
        flexibleSpace: new Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF33D8C3),
                Color(0xFF48CFE1),
              ]
            ),
          ),
        ),
        bottom: new TabBar(
          indicatorColor: new Color(0xFFFFDE80),
          controller: _controller,
          isScrollable: true,
          tabs: [
            new Tab(
              text: "Memorize",

            ),
            new Tab(text: "Recall"),
            new Tab(text: "Record"),
            new Tab(text: "Translation"),
          ]
        )
      ),
      body: new TabBarView(
        controller: _controller,
        children: [
          new Container(
            child: new ListView.builder(
              itemCount: _surah.length,
              itemBuilder: (BuildContext context, int index){
                return new Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: BorderDirectional(
                      bottom: BorderSide(
                        color: Color(0xFFF1F1F1),
                        style: BorderStyle.solid,
                        width: 5.0
                      )
                    )
                  ),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.all(15.0),
                              child: new Text(
                                _surah[index]["arabic"].toString(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 20.0
                                ),
                              ),
                            ),
                            new Padding(padding: EdgeInsets.all(15.0),
                              child: new Text(_surah[index]["indo"].toString())
                            )
                          ],
                        )
                      ),
                      new Container(
                        width: 50.0,
                        decoration: BoxDecoration(
                          border: BorderDirectional(
                            start: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: Color(0xFFF1F1F1)
                            )
                          )
                        ),
                        child: new Center(
                          child: new Text(_surah[index]["verse_id"].toString())
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ),
          new Container(
            child: new Center(
              child: new Text("Challenge yourself by recalling shown ayah number.")
            )
          ),
          new Container(
            child: new Center(
              child: new Text("Listen to your recording and evaluate your murottal.")
            )
          ),
          new Container(
            child: new Center(
              child: new Text("It's better to understand the meaning of every ayah.")
            )
          )
        ]
      )
    );
  }
}