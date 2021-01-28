import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget{

  TextStyle txtStyle = TextStyle(fontFamily: 'Ubuntu-Regular',fontWeight: FontWeight.w600,
      fontSize:17,color: Color(0xFF0191919),);
  TextStyle linkStyle = TextStyle(fontFamily: 'Ubuntu-Regular',fontWeight: FontWeight.bold,
    fontSize:19,color: Color(0xff0457ff),);

  @override
  Widget build(BuildContext context) {

    const firstPart  = "Mitsumori or quote in japanese,"
        " an open source app to help flutter devs learn a few skills."
        " You might have guessed iam an anime fan, yes you are right my friend, plus";
    const secondPart = "is the best anime ever created,"
        " if you think otherwise i suggest you stop using flutter, and use any other crappy"
        " framework like your taste in everything. because flutter is cool and only cool people should use cool things. ";
    return Scaffold(


      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius:60,
                    backgroundImage: AssetImage('assets/images/flutter_icon.png'),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 12,bottom: 4, top: 20),
                child: Text("About"),
              ),
              Center(
                child: Card(
                  child: Column(
                    children: [


                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10 ),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: firstPart,
                                  style: txtStyle,
                                  children: <TextSpan>[

                                    TextSpan(
                                        text: ' AOT ',

                                        style: linkStyle,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // open desired screen
                                            _launchURL("https://www.imdb.com/title/tt2560140/");

                                          }
                                    ),
                                    TextSpan(
                                        text: secondPart,
                                        style: txtStyle
                                    )
                                  ]
                              ),
                            ),
                            SizedBox(height: 10,),
                            ListTile(
                              title: Text("Developed by",style: txtStyle,),
                              trailing: new InkWell(
                                  child: new Text('👨🏽‍💻Maeen Badea',style: linkStyle.merge(TextStyle(color: Colors.green))),
                                  onTap: () => launch('http://maeenbadea.com.nu')
                              ),
                            ),
                            SizedBox(height: 5,),
                            ListTile(
                              title: Text("Design concept",style: txtStyle,),
                              trailing: new InkWell(
                                  child: new Text('‍🎨Stano Bagin',style: linkStyle.merge(TextStyle(color: Colors.redAccent)),),
                                  onTap: () => launch('https://dribbble.com/shots/3526312-Quotes-ios-application')
                              ),
                            ),
                          ],
                        )

                      ),
                      //



                    ],
                  )
                )
              )
            ],
          )
        ),
      ),

    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}



