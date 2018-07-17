import "package:flutter/material.dart";
import "../data/qurandb.dart";
import "../widgets/ayahListItem.dart";

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
              indicatorColor: new Color(0xFFFFDE80),
              controller: _controller,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: _surahs.map( (surah){
                return new Tab(
                  child: new Text(
                    surah["_id"].toString() + ": " + surah["name_english"].toString(),
                    textDirection: TextDirection.ltr,
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
  Map _surahDetail;

  @override
  void initState() {

    super.initState();
    _surah = new List();
    _surahDetail = new Map();

    QuranDatabase().getSurah(widget.id.toString())
      .then( (surah) {
        setState((){
          _surah = surah;
        });
    });

    QuranDatabase().getSurahDetail(widget.id.toString())
      .then( (detail){
        setState((){
          _surahDetail = detail;
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

    return new Container(
      key: widget.key ,
      color: Color(0xFFF0F0F0),
      child: new AnimatedOpacity(
        opacity: _surah.length == 0 ? 0.0 : 1.0 ,
        duration: Duration(milliseconds: 150),
        child: new ListView.builder(
          key: widget.key,
          itemCount: _surah.length,
          itemBuilder: (BuildContext context, int index){
            if (index==0){
              return new Column(
                children: <Widget>[
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new Directionality(textDirection: TextDirection.ltr,
                            child: new Row(
                              children: <Widget>[
                                new Container(
                                  width: 70.0,
                                  child:new Center(child:new Text(_surahDetail["type"].toString())),
                                ),

                                new Expanded(child: new Center(child:Text(_surahDetail["arti_nama"].toString())),flex:1),
                                new Container(
                                  width: 70.0,
                                  child:new Center(child:Text(_surahDetail["ayah_number"].toString())),
                                ),
                              ],
                            ),

                        ),
                        ( int.parse(widget.id) != 1 && int.parse(widget.id) != 9 )
                            ? new Text("Bismillah")
                            : new Container(),
                      ],
                    )
                  ),
                  new Directionality(
                    textDirection: TextDirection.ltr,
                    child: new AyahListItem(
                      ayahNumber: _surah[index]["verse_id"],
                      arabic: _surah[index]["arabic"].toString(),
                      translation: _surah[index]["indo"].toString(),
                    )
                  )
                ],
              );

            } else {
              return new Directionality(
                  textDirection: TextDirection.ltr,
                  child: new AyahListItem(
                    ayahNumber: _surah[index]["verse_id"],
                    arabic: _surah[index]["arabic"].toString(),
                    translation: _surah[index]["indo"].toString(),
                  )
              );
            }


          }
        ),
      )

    );
  }
}