import "package:flutter/material.dart";
import "../data/qurandb.dart";

class QuranReadScreen extends StatefulWidget{

  const QuranReadScreen({
    Key key,
    this.surahs
  }) : super(key: key);

  final List surahs;

  @override
  QuranReadScreenState createState() => new QuranReadScreenState();

}

class QuranReadScreenState extends State<QuranReadScreen> with SingleTickerProviderStateMixin {

  TabController _controller;
  List _surahs;

  @override
  void initState() {
    super.initState();

    _controller = new TabController(length: 114, vsync: this);
    _surahs = widget.surahs;

  }

  Widget build(BuildContext context ) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Read Qur'an"),
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
        bottom: new PreferredSize(
            child: new Directionality(
              textDirection: TextDirection.rtl,
              child: new TabBar(
                controller: _controller,
                isScrollable: true,
                tabs: _surahs.map( (surah){

                  return new Tab(
                    child: new Text(
                      surah["_id"].toString() + ": " + surah["name_english"].toString(),
                    ),

                  );

                }).toList()
              )
            ), 
            preferredSize: Size.fromHeight(48.0)
        )
      ),
      body: new Directionality(
        textDirection: TextDirection.rtl,
        child: new Container(
          child: new TabBarView(
            controller: _controller,

            children: _surahs.map( (surah){

              return new SurahSingleScreen(
                key: new PageStorageKey<String>(surah["name_english"].toString()),
                id:surah["_id"].toString()
              );

            }).toList()
          )
        )
      )

    );
  }

}

class SurahSingleScreen extends StatefulWidget{
  const SurahSingleScreen({
    Key key,
    this.id
  }) : super(key: key);

  final String id;

  @override
  SurahSingleScreenState createState() => new SurahSingleScreenState();
}

class SurahSingleScreenState extends State<SurahSingleScreen> {

  List _surah;

  @override
  void initState() {

    super.initState();
    _surah = new List();

      QuranDatabase().getSurah(widget.id.toString())
        .then( (surah) {
          setState((){
            _surah = surah;
          });

      });

  }

//  @override
//  void dispose() {
//    QuranDatabase.get().close();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      key: widget.key ,
      color: Color(0xFFF0F0F0),
      child: new AnimatedOpacity(
        opacity: _surah.length == 0 ? 0.0 : 1.0 ,
        duration: Duration(milliseconds: 250),
        child: new ListView.builder(
          key: widget.key,
          itemCount: _surah.length,
          itemBuilder: (BuildContext context, int index){
            return new Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: BorderDirectional(
                  bottom: BorderSide(
                    width: 5.0,
                    style: BorderStyle.solid,
                    color: Color(0xFFF0F0F0)
                  )
                )
              ),
              padding: EdgeInsets.only(
                bottom: 20.0,
                top: 20.0,
                left: 15.0,
                right: 15.0
              ),
              child: new Text(
                  _surah[index]["arabic"].toString(),
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 20.0)
              )
            );
          }
        ),
      )

    );
  }
}