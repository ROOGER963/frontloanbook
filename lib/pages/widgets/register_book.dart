import 'package:flutter/material.dart';

class BookInputWidget extends StatelessWidget {
  final TextEditingController tituloController;
  final TextEditingController descripcionController;
  final TextEditingController imagenController;

  const BookInputWidget({
    required this.tituloController,
    required this.descripcionController,
    required this.imagenController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Campo de entrada para el título
        TextField(
          controller: tituloController,
          decoration: InputDecoration(labelText: 'Título'),
        ),
        SizedBox(height: 10),
        // Campo de entrada para la descripción
        TextField(
          controller: descripcionController,
          decoration: InputDecoration(labelText: 'Descripción'),
        ),
        SizedBox(height: 10),
        // Campo de entrada para la imagen
        TextField(
          controller: imagenController,
          decoration: InputDecoration(labelText: 'Imagen'),
        ),
      ],
    );
  }
}
