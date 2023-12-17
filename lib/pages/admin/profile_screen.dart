import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontloanbook/pages/widgets/add_loan.dart';

import 'package:http/http.dart' as http;

class Todoprestamos extends StatefulWidget {
  const Todoprestamos({super.key});

  @override
  State<Todoprestamos> createState() => _TodoprestamosState();
}

class _TodoprestamosState extends State<Todoprestamos> {
  bool isLoading = true;
  List data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fechTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fechTodo,
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final dt = data[index] as Map;
                final id = dt['id'] != null ? dt['id']!.toString() : '';
                return ListTile(
                  leading: CircleAvatar(
                      child: Text(
                    '${index + 1}',
                  )),
                  title: Text(dt['fechaPrestamo']),
                  subtitle: Text(dt['fechaDevolucion']),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'edit') {
                        navigateToEditPrestamo(dt);
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
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPrestamo, label: Text('Prestamo')),
    );
  }

  Future<void> navigateToEditPrestamo(Map dt) async {
    final route = MaterialPageRoute(builder: (context) => AddTodoLoan(todo:dt));
     await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fechTodo();
  }

  Future<void> navigateToAddPrestamo() async {
    final route = MaterialPageRoute(builder: (context) => AddTodoLoan());
    Navigator.push(context, route);
  }

  Future<void> deleteById(String id) async {
    final url = 'http://localhost:8080/api/v1/loans/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered = data.where((element) => element['id'] != id).toList();
      setState(() {
        data = filtered;
      });
    } else {
      showErrosMessage('No se pudo eliminar');
    }
  }

  Future<void> fechTodo() async {
    final url = 'http://localhost:8080/api/v1/loans';
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
      isLoading = false;
    });
  }

  void showErrosMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
