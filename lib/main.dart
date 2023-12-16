import 'package:flutter/material.dart';
import 'package:frontloanbook/pages/inicio_page.dart';
import 'package:frontloanbook/pages/splash_screen.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "inicio",
      routes: {
        "splash":(context) => const SplashScreen(),
        "inicio":(context) => const InicioPage(),
      }
    );
  }
}