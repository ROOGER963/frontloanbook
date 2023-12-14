import 'package:flutter/material.dart';

class CreateLoanrWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Prestamos'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              // Lógica para Crear Libro
              // ...
              Navigator.pop(context); // Cerrar el diálogo
            },
            child: Text('Crear'),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para Actualizar Libro
              // ...
              Navigator.pop(context); // Cerrar el diálogo
            },
            child: Text('Actualizar'),
          ),
        ],
      ),
    );
  }
}
