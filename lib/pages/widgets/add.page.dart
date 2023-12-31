import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({Key? key, this.todo}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController decriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController editorialController = TextEditingController();
  TextEditingController pageController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      titleController.text = todo['titulo'] ?? '';
      decriptionController.text = todo['descripcion'] ?? '';
      imageController.text = todo['imagen'] ?? '';
      categoryController.text = todo['category'] ?? '';
      editorialController.text = todo['editorial'] ?? '';
      pageController.text = (todo['paginas'] ?? '').toString();
      yearController.text = (todo['year'] ?? '').toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libros'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildTextField(titleController, 'Titulo'),
          _buildTextField(decriptionController, 'Descripción', multiline: true),
          _buildTextField(imageController, 'Imagen', multiline: true),
          _buildTextField(categoryController, 'Categoria'),
          _buildTextField(editorialController, 'Editorial'),
          _buildTextField(pageController, 'Paginas'),
          _buildTextField(yearController, 'Año'),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Text(isEdit ? "Actualizar" : "Guardar"),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool multiline = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue), // Color del borde
          ),
          filled: true,
          fillColor: Colors.grey[200], // Color de fondo
          contentPadding: EdgeInsets.all(12),
        ),
        keyboardType: multiline ? TextInputType.multiline : TextInputType.text,
        maxLines: multiline ? null : 1,
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print('no se puede actualizar');
      return;
    }

    final id = todo['id'];

    final title = titleController.text;
    final description = decriptionController.text;
    final imagen = imageController.text;
    final category = categoryController.text; // Asegurarse de que no sea nulo
    final editorial = editorialController.text;
    final page = pageController.text;
    final year = yearController.text;
    final body = {
      "titulo": title,
      "descripcion": description,
      "imagen": imagen,
      "category": category,
      "editorial": editorial,
      "paginas": page,
      "year": year
    };
    final url = 'http://localhost:8080/api/v1/books/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      showSuccessMessage('Actualizado');
    } else {
      showErrorMessage('Error al Actualizar');
    }
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = decriptionController.text;
    final imagen = imageController.text;
    final category = categoryController.text; // Asegurarse de que no sea nulo
    final editorial = editorialController.text;
    final page = pageController.text;
    final year = yearController.text;
    final body = {
      "titulo": title,
      "descripcion": description,
      "imagen": imagen,
      "category": category,
      "editorial": editorial,
      "paginas": page,
      "year": year,
      "is_compled": false
    };

    final url = 'http://localhost:8080/api/v1/books';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      titleController.text = '';
      decriptionController.text = '';
      imageController.text = '';
      categoryController.text = '';
      editorialController.text = '';
      pageController.text = '';
      yearController.text = '';

      print('Create Succes');
      showSuccessMessage('Tu libro fue agregado');
    } else {
      showErrorMessage('Error');
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
        style: TextStyle(color: Colors.black87),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 122, 114),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}