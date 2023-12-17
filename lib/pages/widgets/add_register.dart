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

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(nameController, 'Nombre'),
            SizedBox(height: 10),
            _buildTextField(userController, 'Usuario'),
            SizedBox(height: 10),
            _buildTextField(emailController, 'Email'),
            SizedBox(height: 10),
            _buildPasswordTextField(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitData,
              child: Text('Registrar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? !isPasswordVisible : false,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      controller: passwordController,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
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
      showSuccessMessage('Usuario Creado');
    } else {
      showErrosMessage('No se pudo crear el usuario');
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
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}