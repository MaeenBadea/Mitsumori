import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mitsumori/models/Quote.dart';


class QuoteWidget extends StatelessWidget{

  Quote item;
  QuoteWidget(this.item);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(

            color: Colors.grey.withOpacity(.6),
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: Offset(4.0,2.0), // shadow direction:right bottom
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    item.quote,
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color: Colors.black.withOpacity(.9),fontFamily: 'NotoSerifJP-Regular'),),
                )
              ],
            ),

            SizedBox(height: 12,),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(item.category, style: TextStyle(color: Theme.of(context).primaryColor
              ,fontWeight: FontWeight.w800,fontSize: 13,fontFamily: 'NotoSerifJP-Regular')),
            )
          ],
        ),
      )
    );

  }

}