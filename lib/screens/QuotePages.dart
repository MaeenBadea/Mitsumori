import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mitsumori/models/Quote.dart';
import 'package:mitsumori/repository/DataRepository.dart';

import 'dart:math' as math; // import this
import 'package:flutter/services.dart';
import 'package:share/share.dart';


class QuotePages extends StatefulWidget{
  List<QueryDocumentSnapshot> items;
  int index;
  QuotePages(this.items, this.index);
  @override
  QuotePagesState createState() => QuotePagesState(this.items, this.index);

}

class QuotePagesState extends State<QuotePages> {


  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  DataRepository dataRepository = DataRepository();
  int currentIndex ;
  List<QueryDocumentSnapshot> items  = new List<QueryDocumentSnapshot>();

  //animation
  AnimationController _controller;



  QuotePagesState(this.items, this.currentIndex);

  showSnackBar(String text){
    _scaffold.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    const headerStyle = TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Ubuntu-Regular',
    );
    var categHeaderTxtStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      //fontFamily: 'Ubuntu-Regular',
    );
    var horPadd=  MediaQuery.of(context).size.width/17;
    
    Quote currentQuote = Quote.fromSnapShot(items[currentIndex]);
    String copyText = "\" ${currentQuote.quote} \" \n ${currentQuote.author}";
    print("currrrrrrrrrr $copyText");

    return Scaffold(
          key: _scaffold,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text("Quotes",style: headerStyle),
            leading: IconButton(
              icon: Icon(Icons.close,color: Theme.of(context).primaryColor),
              iconSize: 25,
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            actions: [
              Center(
                  child:Padding(
                    padding: EdgeInsetsDirectional.only(end: 10),
                    child: Text(currentQuote.category,style: categHeaderTxtStyle),
                  )
              )
            ],


          ),
          body: Column(
            children: [

              Expanded(
                child:
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(child: child, opacity: animation);
                  },
                  child: Center(
                    key: ValueKey<int>(currentIndex),
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left:horPadd,right: horPadd,top: 60,bottom: 5),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(currentQuote.quote,textAlign: TextAlign.center,
                                    style: TextStyle(color:Color(0xFF555F61),
                                        fontWeight: FontWeight.w400, fontSize: 24, height: 1.4,fontFamily: 'NotoSerifJP-Regular'
                                    ),
                                  ),
                                  SizedBox(height: 25,),
                                  Text(currentQuote.author, style: TextStyle(color:Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w700, fontSize: 16,fontFamily: 'NotoSerifJP-Regular'),)
                                ],
                              )
                          )
                          ,
                          Positioned(
                            //left: 10,
                            //top: 10,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: Icon(Icons.format_quote, size: 70,color:Colors.grey.withOpacity(.2)),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            right: 1,
                            child: Icon(Icons.format_quote, size: 70,color:Colors.grey.withOpacity(.2)),
                          )
                        ],
                      ),
                    ),

                  )
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  //decoration: BoxDecoration(color: Colors.red),
                  height: MediaQuery.of(context).size.height/8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return ScaleTransition(child: child, scale: animation);
                            },
                            child:Text("${currentIndex+1}",style:
                            TextStyle(color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,fontSize: 19),
                              key: ValueKey<int>(currentIndex),
                            ),
                          ),
                          const Divider(height:8,thickness: 1,color: Colors.grey,),
                          Text("${items.length}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 13),),
                        ],
                      )),
                      Spacer(flex:4),
                       // share quote
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: IconButton(
                          color: Colors.grey,
                          iconSize:35,
                          icon: Icon(Icons.reply),
                          onPressed: (){
                            _onShareData(context, copyText, "");
                          },
                        ),
                      )
                      ,

                      //copy quote
                      Padding(
                      padding:EdgeInsets.only(left:18),
                      child: // copy quote
                      IconButton(
                        color: Colors.grey,
                        iconSize:28,
                        icon: Icon(Icons.copy),
                        onPressed: (){
                          Clipboard.setData(new ClipboardData(text: copyText)).then((value){
                            _scaffold.currentState.showSnackBar(SnackBar(duration: Duration(milliseconds: 600),content: Text("Quote copied to clipboard."),));
                          });
                        },
                      ),
                      ),
                      // next quote
                      Padding(
                        padding:EdgeInsets.only(left:20),
                        child: IconButton(
                          color: Colors.grey,
                          iconSize:28,
                          icon: Icon(Icons.arrow_forward),
                          onPressed: (){
                              if(currentIndex==items.length-1) return;
                              setState(() {
                                currentIndex ++;
                              });
                          },
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),


          // This trailing comma makes auto-formatting nicer for build methods.
    );

  }
  _onShareData(BuildContext context,text, subject) async {

    final RenderBox box = context.findRenderObject();
    {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

}