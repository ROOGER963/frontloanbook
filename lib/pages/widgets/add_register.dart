import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPageRegister extends StatefulWidget {
  const AddPageRegister({Key? key}) : super(key: key);

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
        title: Text('Registro de Usuario'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/profile.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                
                'Completa el formulario para registrarte',
      
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 2, 2, 2),
                  
                ),
                
                
              ),
              
              SizedBox(height: 20),
              _buildTextField(nameController, 'Nombre', Icons.person),
              SizedBox(height: 10),
              _buildTextField(userController, 'Usuario', Icons.account_circle),
              SizedBox(height: 10),
              _buildTextField(emailController, 'Email', Icons.email),
              SizedBox(height: 10),
              _buildPasswordTextField(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitData,
                child: Text(
                  'Registrar',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 9, 74, 128),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon) {
    return TextField(
      controller: controller,
      obscureText: false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        filled: true,
        fillColor: Colors.black.withOpacity(0.5),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0), // Bordes redondos
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      controller: passwordController,
      obscureText: !isPasswordVisible,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Contraseña',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        filled: true,
        fillColor: Colors.black.withOpacity(0.5),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0), // Bordes redondos
          borderSide: BorderSide.none,
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
      showErrorMessage('No se pudo crear el usuario');
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
}