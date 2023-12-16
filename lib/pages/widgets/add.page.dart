import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

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
      final title = todo['titulo'];
      final descripcione = todo['descripcion'];
      final imagen = todo['imagen'];
      final category = todo['category'];
      final editorial = todo['editorial'];
      final paginas = todo['paginas'];
      final yeaer = todo['year'];
      titleController.text = title;
      decriptionController.text = descripcione;
      imageController.text = imagen;
      categoryController.text = category;
      editorialController.text = editorial;
      pageController.text = paginas;
      yearController.text = yeaer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar' : "add todo"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Titulo'),
          ),
          TextField(
            controller: decriptionController,
            decoration: InputDecoration(hintText: 'Descripción'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
          ),
          TextField(
            controller: imageController,
            decoration: InputDecoration(hintText: 'Imagen'),
            keyboardType: TextInputType.multiline,
            maxLines: 3,
          ),
          TextField(
            controller: categoryController,
            decoration: InputDecoration(hintText: 'Categoria'),
          ),
          TextField(
            controller: editorialController,
            decoration: InputDecoration(hintText: 'Editorial'),
          ),
          TextField(
            controller: pageController,
            decoration: InputDecoration(hintText: 'Paginas'),
          ),
          TextField(
            controller: yearController,
            decoration: InputDecoration(hintText: 'Año'),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              child: Text(isEdit ? "Actualizar" : "Guardar"))
        ],
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
    final category = categoryController.text;
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
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

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
    final category = categoryController.text;
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
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

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
