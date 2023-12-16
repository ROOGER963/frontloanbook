import 'package:flutter/material.dart';

class AboutUsPAge extends StatelessWidget {
  const AboutUsPAge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text("Bienvenido a Buscador",style: TextStyle(fontSize: 25)),
      ),
    );
  }
}