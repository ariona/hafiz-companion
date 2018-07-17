import "package:flutter/material.dart";
import "../data/qurandb.dart";
import "../model/Activity.dart";
import "../pages/quranreadScreen.dart";
import "../widgets/modalActivity.dart";


class HomePage extends StatefulWidget{
  @override
  HomePageState createState(){
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController _controller;
  List<Activity> _items;
  List _surahs = new List();
  bool _isLoading;


  @override
  void initState() {
    super.initState();

    _controller = new TabController(length: 3, vsync: this);
    _items = new List<Activity>();
    _surahs = new List();
    _isLoading = true;


    QuranDatabase().getSurahs().then((data){
      setState((){
        _surahs = data;
        _isLoading = false;
      });
    });

  }

  _onValueChange(List value){
    print(value);
    setState(() {
      _items.add(
        new Activity(
          surah: int.parse(value[0]),
          start: int.parse(value[1]),
          end: int.parse(value[2]),
          created: new DateTime.now().toString()
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 18.0
            ),
            children: <TextSpan>[
              TextSpan(
                text: "Hafiz ",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              TextSpan(text:"Companion")
            ]
          )
        ),
        leading: new Icon(Icons.menu),
        actions: <Widget>[
          new Icon(Icons.settings)
        ],
        flexibleSpace: new Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF33D8C3),
                Color(0xFF48CFE1),

              ]
            ),
            image: DecorationImage(
              image: AssetImage("assets/images/header.png"),
              alignment: AlignmentDirectional.centerEnd,
              fit: BoxFit.contain,
            )
          ),
        ),
        bottom: new PreferredSize(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(left: 18.0,bottom: 15.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text("Hello,", style: TextStyle(fontSize:18.0, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w300)),
                    new Text("Rian Ariona", style: TextStyle(fontSize: 24.0, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold))
                  ],
                ),
              ),

              new TabBar(
                  indicatorColor: new Color(0xFFFFDE80),
                  controller: _controller,
                  tabs: [
                    new Tab(
                      text: "Activity",

                    ),
                    new Tab(text: "History"),
                    new Tab(text: "Progress"),
                  ]
              )
            ],
          ),
          preferredSize: Size.fromHeight(130.0)
        )
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new Container(
              height: 100.0,
            ),
            new ListTile(
              leading: new Icon(Icons.bubble_chart),
              title: new Text("Hafiz Mode"),
            ),
            new ListTile(
              leading: new Icon(Icons.chrome_reader_mode),
              title: new Text("Read Mode"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QuranReadScreen(surahs: _surahs),
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: new TabBarView(
        controller: _controller,
        children: [

          new Container(
              color: Color(0xFFe9ecef),
              child: _items.length == 0 ? new Text("No Activity") : new ListView.builder(
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index){
                  return new Card(
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          leading: new CircleAvatar(
                              backgroundColor: Color(0xFF33D8C4),
                              child: new Text("2", style: TextStyle(color: Color(0xFFFFFFFF),fontWeight: FontWeight.bold))
                          ),
                          title: new Text("Al-Baqarah", style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: new Text("Ayah 20 – 25"),
                          trailing: new Text("البقرة", style: TextStyle(
                              fontSize: 24.0
                          )),
                        ),
                        new Container(
                            padding: EdgeInsets.all(14.0),
                            color: Color(0xFFF3F3F3),
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                    child: new RichText(
                                        text: new TextSpan(
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text: 'Started at ',
                                                  style: TextStyle(color:Colors.black45)
                                              ),
                                              new TextSpan(
                                                  text: "1 July 2018",
                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)
                                              )
                                            ]
                                        )
                                    )
                                ),

                                new OutlineButton(
                                  borderSide: BorderSide(
                                      color: Color(0xFF36D7C7),
                                      style: BorderStyle.solid,
                                      width: 5.0
                                  ),
                                  color: Colors.teal,
                                  onPressed: (){
                                    Navigator.of(context).pushNamed('/activity');
                                  },
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                  child: new Text("Memorize",style:TextStyle(color: Color(0xFF495057))),
                                  highlightColor: Color(0xFF36D7C7),
                                  highlightedBorderColor: Color(0xFF36D7C7),
                                  textColor: Color(0xFF36D7C7),
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  );
                },
                padding: EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                    right: 10.0,
                    bottom: 100.0
                ),

              )
          ),
          new Container(
            color: Color(0xFFe9ecef),
            child: new Center(
              child: new Text("No History, Finish your activity")
            )
          ),
          new Container(
              color: Color(0xFFe9ecef),
              child: new Center(
                  child: new Text( "App is loading" + _isLoading.toString() )
              )
          ),


        ]

      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          print("tahu bulat");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return new NewActivityModal(
                surahs: _surahs,
                onValueChange: _onValueChange,
                initialValue: "1",
              );
            }

          );
        },
        child: new Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }


}