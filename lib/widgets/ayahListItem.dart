import "package:flutter/material.dart";

class AyahListItem extends StatelessWidget{
  final String arabic;
  final String translation;
  final int ayahNumber;

  const AyahListItem({
    this.arabic,
    this.translation,
    this.ayahNumber
  });

  @override
  Widget build(BuildContext context){
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
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Row(
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
                        new Text(this.ayahNumber.toString(), style: TextStyle(fontSize:12.0,fontWeight: FontWeight.w500)),
                      ],
                    )
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
                      this.arabic,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 20.0
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        )

    );
  }

}