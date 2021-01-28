import 'package:flutter/material.dart';
import 'package:mitsumori/models/Quote.dart';
import 'package:mitsumori/repository/DataRepository.dart';
import 'package:mitsumori/widgets/indicators.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class AddQuote extends StatefulWidget{
  @override
  AddQuoteState createState() => AddQuoteState();
  
}

class AddQuoteState extends State<AddQuote>{

  String _quote = "";
  String _author= "";
  String _categ ="";

  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  DataRepository dataRepository = DataRepository();

  TextEditingController _quoteController = new TextEditingController();
  TextEditingController _authorController = new TextEditingController();
  TextEditingController _categController = new TextEditingController();

  /*_quoteController.text = _quote;
  _authorController.text = _author;
  _categController.text = _categ;*/

  addQuote(){
    if(_quote.isEmpty || _author.isEmpty || _categ.isEmpty){
      showSnackBar("please fill all required fields.");
      return ;
    }
    setState(() {
      _isLoading = true;
    });
    Quote quote = new Quote(_quote, _author, _categ);
    dataRepository.addQuote(quote,
            (){
                stopProgress();
                Future.delayed(Duration(microseconds: 300),(){
                  Navigator.of(context).pop();
                  showAlertDialog("Status","quote added successfully");
                });

            },
            (){ showSnackBar("failed adding quote."); stopProgress(); }
    );



  }
  showAlertDialog(String title , String message){
    showDialog(context: context, builder: (_)=> AlertDialog(title: Text(title),content: Text(message)) );
  }
  showSnackBar(String text){
    _scaffold.currentState.showSnackBar(SnackBar(content: Text(text)));
  }
  stopProgress(){
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    const contentStyle = TextStyle(fontFamily: 'Ubuntu-Regular',fontWeight: FontWeight.w600,
        fontSize:17,color: Color(0xFF0191919));
    const headerStyle = TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontFamily: 'Molle-Italic',
    );


    return ModalProgressHUD(
      progressIndicator: chasingDotsProgress(context),
      inAsyncCall: _isLoading,
      child: Scaffold(
        key: _scaffold,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Quote",style: headerStyle),
          leading: IconButton(
            icon: Icon(Icons.close,color: Theme.of(context).primaryColor),
            iconSize: 25,
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),

        ),
        body: ListView(
          padding: EdgeInsets.only(left:20,right: 20, top: 40,bottom: 40),
          children: [
            TextField(
              controller: _quoteController,
              textAlign: TextAlign.center,
              style: contentStyle,
              maxLines: 7,
              onChanged: (txt){
                setState(() {
                  _quote = _quoteController.text;
                });
                print('new val $txt');
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 14),
                  labelText: "Enter quote here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _authorController,
              style: contentStyle,
              onChanged: (txt){
                setState(() {
                  _author = _authorController.text;
                });
                print('new val $txt');
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "author",
                  border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  )
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _categController,
              style: contentStyle,
              onChanged: (txt){
                setState(() {
                  _categ= _categController.text;
                });
                print('new val $txt');
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "category",
                  border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  )
              ),
            ),
            SizedBox(height: 10,),
            Center(
                child:SizedBox(
                  width: MediaQuery.of(context).size.width/1.5,
                  child: RaisedButton(
                    splashColor: Colors.blue,
                    color: Color(0xff0457ff),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 7,),
                      child:Text("Save", style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.w700, fontSize: 19,fontFamily:'Molle-Italic'),),
                    ),
                    onPressed:addQuote,
                  ),
                )
            )
          ],
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      )
    );




  }

  
}