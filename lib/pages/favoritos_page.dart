import 'package:flutter/material.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text("Bienvenido a Favoritos", style: TextStyle(fontSize: 25),),
      ),
    );
  }
}
