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
              return Card(
                elevation: 5.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        dt["titulo"],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Imagen
                    Center(
                      child: Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(dt["imagen"]),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'edit') {
                                navedateToEditPage(dt);
                                // Agregar lógica para la edición si es necesario
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
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddTodoPage();
            },
          );
        },
        label: Text('Crear Libros'),
      ),
    );
  }

  void navedateToEditPage(Map dt) {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage(todo:dt));
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
