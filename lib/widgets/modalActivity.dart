import "package:flutter/material.dart";
import "../widgets/modalSurah.dart";

class NewActivityModal extends StatefulWidget{
  const NewActivityModal({this.surahs, this.onValueChange, this.initialValue});

  final List surahs;
  final String initialValue;
  final void Function(List) onValueChange;

  @override
  NewActivityModalState createState() => new NewActivityModalState();
}

class NewActivityModalState extends State<NewActivityModal> {

  String _selectedId;
  int _totalAyah;

  final _startAyah = TextEditingController();
  final _endAyah = TextEditingController();

  @override
  initState() {
    super.initState();
    _selectedId = widget.initialValue;
    _totalAyah = 7;
  }

  showSurahPicker(){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return new SurahDialog(
          surahs: widget.surahs,
          onValueChange: _onValueChange,
          initialValue: _selectedId,
        );
      }
    );
  }

  void _onValueChange(List value){
    print("testing $value");
    setState((){
      _selectedId = value[0].toString();
      _totalAyah = int.parse(value[1]);
    });
  }

  Widget build(BuildContext context){
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
          padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                child:new Text("Surah", style: TextStyle(
                  color: Colors.teal,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                )),
                padding: EdgeInsets.only(bottom: 5.0),
              ),
              new FlatButton(
                onPressed: showSurahPicker,
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(widget.surahs[int.parse(_selectedId)-1]["name_english"], style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500
                            )),
                            new Text(widget.surahs[int.parse(_selectedId)-1]["ayah_number"]+" Ayahs", style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400
                            ))
                          ],
                        )
                    ),
                    new Icon(Icons.search)
                  ],
                )
              )
            ],
          )
        ),
        new Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Expanded(
                  child:new Text("Start Ayah", style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)
                  ),
                  flex: 2,
                ),
                new Expanded(
                  child:new TextField(
                    controller: _startAyah,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "1"
                    ),
                  ),
                  flex: 1,
                ),

              ],
            )
        ),
        new Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Expanded(
                  child:new Text("End Ayah", style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)
                  ),
                  flex: 2,
                ),
                new Expanded(
                  child:new TextField(
                    controller: _endAyah,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: _totalAyah.toString()
                    ),
                  ),
                  flex: 1,
                ),

              ],
            )
        ),
        new Center(
          child: new Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: new RaisedButton(
              onPressed: (){
                Navigator.pop(context);
                widget.onValueChange([
                  _selectedId,
                  _startAyah.text,
                  _endAyah.text
                ]);
              },
              color: Colors.teal,
              child: new Text("Start Memorize", style: TextStyle(color: Colors.white)),
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            ),
          )
        )
      ],

    );
  }
}