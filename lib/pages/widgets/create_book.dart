import 'package:flutter/material.dart';
import 'package:frontloanbook/pages/widgets/add.page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CreateBookLoan extends StatefulWidget {
  const CreateBookLoan({Key? key}) : super(key: key);

  @override
  State<CreateBookLoan> createState() => _CreateBookLoanState();
}

class _CreateBookLoanState extends State<CreateBookLoan> {
  bool isLoan = true;
  List data = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libros'),
        backgroundColor: Color.fromRGBO(30, 63, 104, 1),
      ),
      body: Visibility(
        visible: isLoan,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final dt = data[index] as Map;
              final id = dt['id'] != null ? dt['id']!.toString() : '';

              return buildBookCard(dt["titulo"], dt["imagen"], id);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddTodoPage(),
          );
        },
        label: Text('Crear Libros'),
        backgroundColor: Color.fromARGB(255, 63, 81, 181),
      ),
      backgroundColor: const Color.fromARGB(255, 168, 194, 233), // Fondo azul oscuro
    );
  }

  Widget buildBookCard(String title, String imageUrl, String id) {
    return Card(
      elevation: 5.0,
      color: Color.fromARGB(30, 63, 104, 1), // Fondo gris claro
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleAndImageRow(title, imageUrl),
          buildOptionsRow(id),
        ],
      ),
    );
  }

  Widget buildTitleAndImageRow(String title, String imageUrl) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0), // Texto azul
              ),
            ),
          ),
        ),
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOptionsRow(String id) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'edit') {
                navigateToEditPage(id);
              } else if (value == 'delete') {
                deleteById(id);
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Editar'),
                  value: 'edit',
                ),
                PopupMenuItem(
                  child: Text('Eliminar'),
                  value: 'delete',
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

  void navigateToEditPage(String id) {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: data.firstWhere((e) => e['id'] == id)),
    );
    Navigator.push(context, route);
  }

  Future<void> navedateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    await Navigator.push(context, route);
    setState(() {
      isLoan = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    final url = 'http://localhost:8080/api/v1/books/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      final filtered = data.where((element) => element['id'] != id).toList();
      setState(() {
        data = filtered;
      });
    } else {
      showErrorMessage('No se pudo eliminar');
    }
  }

  Future<void> fetchTodo() async {
    final url = 'http://localhost:8080/api/v1/books';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['data'] as List;
      setState(() {
        data = result;
      });
    }
    setState(() {
      isLoan = false;
    });
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.black87),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 122, 114),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}