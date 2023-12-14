import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      throw Exception("Fallo la conexion");
    }

    setState(() {
      loanData =
          List<Map<String, dynamic>>.from(json.decode(response.body)['data']);
    });
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        title: Text('Libros'),
        backgroundColor: const Color.fromARGB(255, 60, 64, 89),
      ),
    );
  }

 
Widget buildBookItem(int index) {
  return Container(
    margin: EdgeInsets.all(10.0),
    child: Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen
          Center(
            child: Container(
              width: 150.0,
              height: 150.0,  // Ajusta esta altura para que sea cuadrada
              decoration: BoxDecoration(
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
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  // Descripción
                  Text(
                    "${loanData[index]["descripcion"]}",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  // Categoría
                  SizedBox(height: 4.0),
                  Text(
                    "Categoría: ${loanData[index]["category"]}",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Editorial: ${loanData[index]["editorial"]}",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Paginas: ${loanData[index]["paginas"]}",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Año: ${loanData[index]["year"]}",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
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
      body: ListView.builder(
        itemCount: loanData.length,
        itemBuilder: (BuildContext context, int index) {
          return buildBookItem(index);
        },
      ),
    );
  }
}
