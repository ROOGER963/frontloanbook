import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddTodoLoan extends StatefulWidget {
  final Map? todo;

  const AddTodoLoan({Key? key, this.todo}) : super(key: key);

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

    // Asegúrate de que las fechas iniciales cumplan con la condición del predicado
    if (!isWeekday(_selectedLoanDate)) {
      _selectedLoanDate = getNextWeekday(_selectedLoanDate);
    }
    if (!isWeekday(_selectedReturnDate)) {
      _selectedReturnDate = getNextWeekday(_selectedReturnDate);
    }
  }

  bool isWeekday(DateTime date) {
    return date.weekday >= 1 && date.weekday <= 5;
  }

  DateTime getNextWeekday(DateTime date) {
    // día laborable (lunes a viernes)
    while (!isWeekday(date)) {
      date = date.add(Duration(days: 1));
    }
    return date;
  }

  Future<void> _selectDate(bool isLoanDate) async {
    DateTime selectedDate = DateTime.now();

    selectedDate = (await showDatePicker(
          context: context,
          initialDate: isLoanDate ? _selectedLoanDate : _selectedReturnDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
          selectableDayPredicate: (DateTime date) {
            return isWeekday(date);
          },
        )) ??
        DateTime.now();

    setState(() {
      if (isLoanDate) {
        _selectedLoanDate = getNextWeekday(selectedDate);
        dateLoanController.text = formatDate(_selectedLoanDate);
      } else {
        _selectedReturnDate = getNextWeekday(selectedDate);
        returnDateController.text = formatDate(_selectedReturnDate);
      }
    });
  }

  String formatDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  Future<void> updateDate() async {
    final todo = widget.todo;
    if (todo == null) {
      print('No se pudo llamar a los datos');
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
      showErrorMessage('Algo salió mal');
    }
  }

  Future<void> submitData() async {
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
      showErrorMessage('Algo salió mal');
      print('Error');
      print(response.body);
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar Prestamo' : 'Prestamo'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: dateLoanController,
            readOnly: true,
            onTap: () async {
              await _selectDate(true);
            },
            decoration: InputDecoration(
              hintText: 'Fecha de Prestamo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: returnDateController,
            readOnly: true,
            onTap: () async {
              await _selectDate(false);
            },
            decoration: InputDecoration(
              hintText: 'Fecha de Devolucion',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: EdgeInsets.all(16.0),
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
}
