import "package:flutter/material.dart";
import "qurandb.dart";
import "quranread.dart";

void main() {
  runApp( new MyApp() );
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Hafiz Companion',
      theme: new ThemeData(
        primaryColor: Colors.teal
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => HomePage(),
        '/activity' : (BuildContext context) => ActivityScreen(),
        '/read': (BuildContext context) => QuranReadScreen()
      }
    );
  }

}

class Activity {
  final int surah;
  final int start;
  final int end;
  final String created;

  const Activity({
    this.surah,
    this.start,
    this.end,
    this.created
  });
}

class HomePage extends StatefulWidget{



  @override
  HomePageState createState(){
    QuranDatabase.get().init();
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController _controller;
  List<Activity> _items;
  List _surahs = new List();
  Map _selectedSurah = new Map();

  @override
  void initState() {
    super.initState();

    _controller = new TabController(length: 3, vsync: this);
    _items = new List<Activity>();
    _surahs = new List();
    _selectedSurah = new Map();

    QuranDatabase.get().init().then((data){
      QuranDatabase.get().getSurahs().then((data){
        setState((){
          _surahs = data;
        });
      });
    });

  }

  surahDialog(){

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          titlePadding: EdgeInsets.all(0.0),
          title: new Container(
            padding: EdgeInsets.all(15.0),
            color: Colors.teal,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Select Surah",style: TextStyle(color:Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold)),
                new TextField(
                  decoration: new InputDecoration(
                    fillColor: Colors.red
                  ),
                )
              ],
            ),
          ),
          contentPadding: new EdgeInsets.all(0.0),
          children: <Widget>[
            new Container(
                height: 200.0,
                child: new ListView.builder(
                    itemCount: _surahs.length,
                    itemBuilder: (BuildContext context, int index){
                      return new ListTile(
                        leading: new CircleAvatar(
                          child: new Text(_surahs[index]["_id"].toString()),
                        ),
                        title: new Text(_surahs[index]["name_english"].toString()),
                        subtitle: new Text("${_surahs[index]["ayah_number"].toString()} Ayahs"),
                        trailing: new Text(_surahs[index]["name_arabic"].toString()),
                        onTap: (){
                          setState((){
                            _selectedSurah = _surahs[index];

                            Navigator.pop(context);
                          });
                        },
                      );

                    }
                )
            )


          ],

        );
      }
    );

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
      body: new TabBarView(
        controller: _controller,
        children: [
          new Container(
            color: Color(0xFFe9ecef),
            child: _items.length == 0 ? new Text("No Activity") : new ListView.builder(
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int position){
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
                child: new Text("Memorization Progress")
            )
          ),

        ]

      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){

          // Navigator.of(context).pushNamed('/read');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuranReadScreen(surahs: _surahs),
            ),
          );

          /*
          if ( _surahs.length == 0 ) {
            QuranDatabase.get().getSurahs().then((data){
              setState((){
                _surahs = data;
              });
            });
          }


          showDialog(
            context: context,
            builder: (BuildContext context){

              return new SimpleDialog(
                titlePadding: EdgeInsets.all(0.0),
                title: new Container(
                  padding: EdgeInsets.all(15.0),
                  color: Colors.teal,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("New Activity",style: TextStyle(color:Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold)),
                      new Text("Create new ayahs memorization activity", style: TextStyle(fontSize:14.0,color: Colors.white, fontWeight: FontWeight.w300))
                    ],
                  ),
                ),

                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Surah", style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
                        new FlatButton(
                          onPressed: (){
                            surahDialog();
                          },
                          child: new Text(_selectedSurah["name_english"].toString())
                        )

                      ],
                    )
                  ),
                  new Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                      child: new Column(
                        children: <Widget>[
                          new Text("Start Ayah", style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
//                          new DropdownButton(
//                              items: (){
//                                return [];
//                              },
//                              onChanged: null
//                          )
                        ],
                      )
                  ),
                  new Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: new Column(
                        children: <Widget>[
                          new Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("End Ayah", style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
                              new Row(
                                children: <Widget>[
                                  new Expanded(child: new Text("10", style: TextStyle(fontSize: 16.0))),
                                  new Icon(Icons.arrow_drop_down)
                                ],
                              )

                            ],
                          )
                        ],
                      )
                  ),
                  new Center(
                    child: new RaisedButton(
                      onPressed: (){
                        setState(() {
                          _items.add(new Activity(
                              surah: 1,
                              start: 20,
                              end: 30,
                              created: "10 Jun 2018"
                          ));
                        });
                        Navigator.pop(context);

//                        Navigator.of(context).pushNamed('/activity');
                      },
                      color: Colors.teal,
                      child: new Text("Start Memorize", style: TextStyle(color: Colors.white)),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    ),
                  )
                ],

              );
            }
          );
          */
        },
        child: new Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
//
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

    QuranDatabase.get().getAyahsRange(1, 1, 7)
      .then( (data){
        if (data==null) return;
        setState(() {
          _surah = data;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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


class FlexibleAppBar extends AppBar {
  static const double height = 256.0;

  FlexibleAppBar(String title, String imageUrl) : super(
//      expandedHeight: height,
      flexibleSpace: new FlexibleSpaceBar(
          title: new Text(title),
          background: _buildBackground(imageUrl)
      )
  );

  static Widget _buildBackground(String imageUrl) {
    return new Stack (
        children: <Widget>[
          new Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: height
          ),

          new DecoratedBox(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      begin: const FractionalOffset(0.5, 0.6),
                      end: const FractionalOffset(0.5, 1.0),
                      colors: <Color>[const Color(0x00000000), const Color(0x70000000)]
                  )
              )
          )
        ]
    );
  }

}

