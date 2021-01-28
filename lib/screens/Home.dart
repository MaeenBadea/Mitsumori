
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mitsumori/models/Quote.dart';
import 'package:mitsumori/repository/DataRepository.dart';
import 'package:mitsumori/screens/AddQuote.dart';
import 'package:mitsumori/screens/about.dart';
import 'package:mitsumori/widgets/quote_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'QuotePages.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  int count = 0;
  int axisCount = 2;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedTab = 0;
  final DataRepository repository = DataRepository();
  bool _isLoading;


  var txtStyle = TextStyle(
    color: Colors.red,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    fontFamily: 'GreatVibes-Regular',
  );
  var textStyle = TextStyle(fontFamily: 'Ubuntu-Regular',fontWeight: FontWeight.w600,
      fontSize:17,color: Colors.blueGrey);

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }


  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Quotes",style: txtStyle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.add,color: Theme.of(context).primaryColor),
          iconSize: 25,
          onPressed: (){
            _navToAddQuote();
          },
        ),
      ),
      body:_selectedTab==0? StreamBuilder<QuerySnapshot>(

          stream: repository.getStream(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              print(snapshot.connectionState);
              if (snapshot.hasError) {
                return _errorWidget();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: EdgeInsets.only(top:30),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                      )
                  ),
                );
              }
              if (!snapshot.hasData){
                return _emptyWidget();
              }
                var data = snapshot.data;
                return Container(
                  child: getQuotesList(data.docs , data.size),
                );





            //return _buildList(context, snapshot.data.documents);
          }): About(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.format_quote_rounded,size: 30,), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.insights), label: ""),
        ],
        currentIndex: _selectedTab,
        onTap: (int index){
          if(_selectedTab==index) return;
          setState(() {
            _selectedTab = index;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  getQuotesList(List<QueryDocumentSnapshot> snaps, size){

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: StaggeredGridView.countBuilder(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 4,
        itemCount: size,
        itemBuilder: (BuildContext context, int index){
//            Map<String,dynamic> item = quotes[index].data();
            Quote item = Quote.fromSnapShot(snaps[index]);
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return QuotePages(snaps,index);
                  }));
                },
                child: QuoteWidget(item)
            );
          }
        ,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),//count(2,index.isEven ?  2 : 2.2),
        mainAxisSpacing: 30.0,
        crossAxisSpacing: 15.0,
      ),
    );
  }
  _errorWidget(){
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                color: Color(0xFF8a2929),
                iconSize: MediaQuery.of(context).size.width/3,
                icon:Icon(Icons.error_outline_outlined ),
                onPressed: (){

                }),
            SizedBox(height: 20,),
            Text("error loading quotes.",style: textStyle,)
          ],
        )
    );
  }
  _emptyWidget(){
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                color: Color(0xFF0191919),
                iconSize: MediaQuery.of(context).size.width/3,
                icon:Icon(Icons.add_to_photos_outlined ),
                onPressed: (){
                      _navToAddQuote();
                }),
            SizedBox(height: 20,),
            Text("There are no quotes.",style: textStyle,)
          ],
        )
    );
  }
  _navToAddQuote(){
    Navigator.of(context).push(_createRoute());
  }
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddQuote(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

}


