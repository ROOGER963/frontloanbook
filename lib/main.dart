import 'package:flutter/material.dart';
import 'package:frontloanbook/pages/home_page.dart';
import 'package:frontloanbook/pages/login_page.dart';
import 'package:frontloanbook/pages/menu_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
       theme: ThemeData.dark(),
        initialRoute: "Home",
        routes: <String, WidgetBuilder>{
          "Home": (BuildContext context) => LoginPage(),
          "Menu": (BuildContext context) => MenuLateral(),
          "Book": (BuildContext context) => HomePage(),
        });
  }
}
