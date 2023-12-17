import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddTodoLoan extends StatefulWidget {
  final Map? todo;
  const AddTodoLoan({super.key, this.todo});

  @override
  State<AddTodoLoan> createState() => _AddTodoLoanState();
}

class _AddTodoLoanState extends State<AddTodoLoan> {
  late DateTime _selectedLoanDate;
  late DateTime _selectedReturnDate;

  TextEditingController dateLoanController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final dateLoan = todo['fechaPrestamo'];
      final returnDate = todo['fechaDevolucion'];
      dateLoanController.text = dateLoan;
      returnDateController.text = returnDate;
    }
    _selectedLoanDate = DateTime.now();
    _selectedReturnDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar Prestamo' : 'Prestamo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: dateLoanController,
            readOnly: true,
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: _selectedLoanDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null && selectedDate != _selectedLoanDate) {
                setState(() {
                  _selectedLoanDate = selectedDate;
                  dateLoanController.text = formatDate(selectedDate);
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'Fecha de Prestamo',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: returnDateController,
            readOnly: true,
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: _selectedReturnDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null && selectedDate != _selectedReturnDate) {
                setState(() {
                  _selectedReturnDate = selectedDate;
                  returnDateController.text = formatDate(selectedDate);
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'Fecha de Devolucion',
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: isEdit ? updateDate : submitData,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(isEdit ? 'Actualizar' : 'Crear Prestamo'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateDate() async {
    final todo = widget.todo;
    if (todo == null) {
      print('No se pudo llamar a las datos');
      return;
    }
    final id = todo['id'];
    final dateLoan = formatDate(_selectedLoanDate);
    final returnDate = formatDate(_selectedReturnDate);
    final body = {
      "fechaPrestamo": dateLoan,
      "fechaDevolucion": returnDate,
      "estadoPrestamo": false,
    };
    final url = 'http://localhost:8080/api/v1/loans/$id';
    final uri = Uri.parse((url));
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
     
      showSuccessMessage('Actualización Hecha');
    } else {
      showErrosMessage('Algo salio mal');
     
    }
  }

  String formatDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  void submitData() async {
    final dateLoan = formatDate(_selectedLoanDate);
    final returnDate = formatDate(_selectedReturnDate);
    final body = {
      "fechaPrestamo": dateLoan,
      "fechaDevolucion": returnDate,
      "estadoPrestamo": false,
    };

    final url = 'http://localhost:8080/api/v1/loans';
    final uri = Uri.parse((url));
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      dateLoanController.text = '';
      returnDateController.text = '';
      print("Creado fechas de prestamos");
      showSuccessMessage('Creación de fechas');
    } else {
      showErrosMessage('Algo salio mal');
      print('Error');
      print(response.body);
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
