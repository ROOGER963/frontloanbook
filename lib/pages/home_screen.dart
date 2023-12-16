import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> loanData = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    final Uri url = Uri.parse('http://localhost:8080/api/v1/books');
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      print("Puedes ver tus datos");
    } else {
      throw Exception("Fallo la conexión");
    }

    setState(() {
      loanData = List<Map<String, dynamic>>.from(json.decode(response.body)['data']);
    });
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        title: Text('Libros'),
        backgroundColor: Color.fromARGB(255, 52, 69, 183), // Azul elegante
      ),
    );
  }

  Widget buildBookItem(int index) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Card(
        elevation: 5.0,
        color: Colors.blue[50], // Fondo azul claro
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            Center(
              child: Container(
                width: 150.0,
                height: 150.0, // Ajusta esta altura para que sea cuadrada
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(loanData[index]["imagen"]),
                  ),
                ),
              ),
            ),
            // Información
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    "${loanData[index]["titulo"]}",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.blue[900]), // Texto azul oscuro
                  ),
                  SizedBox(height: 8.0),
                  // Descripción
                  Text(
                    "${loanData[index]["descripcion"]}",
                    style: TextStyle(fontSize: 14.0, color: const Color.fromARGB(255, 81, 79, 79)),
                  ),
                  // Categoría
                  SizedBox(height: 4.0),
                  Text(
                    "Categoría: ${loanData[index]["category"]}",
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: const Color.fromARGB(255, 80, 79, 79)),
                  ),
                  Text(
                    "Editorial: ${loanData[index]["editorial"]}",
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 80, 79, 79)),
                  ),
                  Text(
                    "Páginas: ${loanData[index]["paginas"]}",
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 80, 79, 79)),
                  ),
                  Text(
                    "Año: ${loanData[index]["year"]}",
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 80, 79, 79)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columnas
          crossAxisSpacing: 8.0, // Espaciado horizontal
          mainAxisSpacing: 8.0, // Espaciado vertical
        ),
        itemCount: loanData.length,
        itemBuilder: (BuildContext context, int index) {
          return buildBookItem(index);
        },
      ),
    );
  }
}