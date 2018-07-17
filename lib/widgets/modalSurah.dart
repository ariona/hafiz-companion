import "package:flutter/material.dart";

class SurahDialog extends StatefulWidget{
  const SurahDialog({this.surahs,this.initialValue,this.onValueChange});

  final List surahs;
  final String initialValue;
  final void Function(List) onValueChange;

  @override
  SurahDialogState createState() => new SurahDialogState();
}

class SurahDialogState extends State<SurahDialog>{

  @override
  Widget build(BuildContext context) {
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
            itemCount: widget.surahs.length,
            itemBuilder: (BuildContext context, int index){
              return new ListTile(
                leading: new CircleAvatar(
                  child: new Text(widget.surahs[index]["_id"].toString()),
                ),
                title: new Text(widget.surahs[index]["name_english"].toString()),
                subtitle: new Text("${widget.surahs[index]["ayah_number"].toString()} Ayahs"),
                trailing: new Text(widget.surahs[index]["name_arabic"].toString()),
                onTap: (){
                  Navigator.pop(context);
                  widget.onValueChange([widget.surahs[index]["_id"].toString(),widget.surahs[index]["ayah_number"]]);
                }
              );
            }
          )
        )


      ],

    );
  }
}