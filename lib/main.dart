import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mitsumori/screens/Home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  primarySwatch: Colors.blue,
  accentColor: Colors.blueAccent,
  hintColor: Colors.blueGrey,
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0x003366),
  ),
  textTheme: TextTheme(
    title: TextStyle(
      color: Colors.black,
    ),



  ),

  visualDensity: VisualDensity.adaptivePlatformDensity,
);
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  accentColor: Colors.greenAccent,
  hintColor: Colors.deepOrangeAccent,

  textTheme: TextTheme(
    title: TextStyle(
      color: Colors.white,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
