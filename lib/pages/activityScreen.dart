import "package:flutter/material.dart";
import "../data/qurandb.dart";
import "../model/Activity.dart";

class ActivityScreen extends StatefulWidget{
  final Activity data;

  ActivityScreen({this.data});

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

    QuranDatabase().getAyahsRange(widget.data.surah, widget.data.start, widget.data.end)
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
                  new Text("Ayah ${widget.data.start}-${widget.data.end}", style: TextStyle(fontSize:12.0,fontWeight: FontWeight.w300))
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
                  new Tab(text: "Wordbyword"),
                ]
            )
        ),
        body: new TabBarView(
            controller: _controller,
            physics: new NeverScrollableScrollPhysics(),
            children: [
              new Container(
                child: new ListView.builder(
                itemCount: _surah.length,
                itemBuilder: (BuildContext context, int index){
                  return new Container
                    (
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                            width: 50.0,
                            height: 64.0,
                            child: new Stack(
                              alignment: Alignment(0.0, 0.0),
                              children: <Widget>[
                                new Positioned(
                                    width: 35.0,
                                    height: 45.0,
                                    child: new Container(
                                        child: new Image.asset(
                                          "assets/images/circle-deco.png",
                                          width: 35.0,
                                          height: 45.0,
                                        )
                                    )
                                ),
                                new Text(_surah[index]["verse_id"].toString(), style: TextStyle(fontSize:12.0,fontWeight: FontWeight.w500)),
                              ],
                            )
//                          child: new Center(
//                              child: new Text(_surah[index]["verse_id"].toString())
//                          ),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: BorderDirectional(
                                start: BorderSide(
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                  color: Color(0xFFF1F1F1)
                                )
                              )
                            ),
                            child: new Text(
                              _surah[index]["arabic"].toString(),
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 20.0
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                  },
                )
              ),
              new Container
                (
                  child: new Column(
                  children: <Widget>[


                  ],
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