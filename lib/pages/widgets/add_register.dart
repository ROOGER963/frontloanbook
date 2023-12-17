import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPageRegister extends StatefulWidget {
  const AddPageRegister({super.key});

  @override
  State<AddPageRegister> createState() => _AddPageRegisterState();
}

class _AddPageRegisterState extends State<AddPageRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('registro'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'Nombre'),
          ),
          TextField(
            controller: userController,
            decoration: InputDecoration(hintText: 'usuario'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(hintText: 'Contraseña'),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(onPressed: submitData, child: Text('Registrar'))
        ],
      ),
    );
  }

  Future<void> submitData() async {
    final name = nameController.text;
    final user = userController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final body = {
      "nombre": name,
      "nombreUsuario": user,
      "email": email,
      "password": password
    };
    final url = 'http://localhost:8080/api/v1/users';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      nameController.text = '';
      userController.text = '';
      emailController.text = '';
      passwordController.text = '';
      print('Usuario creado');
      showErrosMessage('Usuario Creado');
    }
    showErrosMessage('No se pudo crear el usuario');
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
