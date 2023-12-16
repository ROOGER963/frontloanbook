import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:frontloanbook/pages/admin/users_page.dart';



class LoginPage extends StatelessWidget {
  static const String routeName = '/home';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final correoEjemplo = '';
  final contrasenaEjemplo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: FadeInUp(
                      child: Image.asset(
                        'images/profile.png',
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            FadeInUp(
              duration: Duration(milliseconds: 1600),
              child: Center(
                child: Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 108, 107, 107),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 210, 231, 254),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      FadeInUp(
                        duration: Duration(milliseconds: 1400),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(30, 128, 232, 0.715),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              buildTextField(
                                controller: emailController,
                                hintText: "Correo electrónico",
                                prefixIcon: Icons.email,
                              ),
                              buildTextField(
                                controller: passwordController,
                                hintText: "Contraseña",
                                prefixIcon: Icons.lock,
                                isObscure: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      FadeInUp(
                        duration: Duration(milliseconds: 1600),
                        child: buildMaterialButton(
                          onPressed: () => _onLoginPressed(context),
                          text: "Ingresar",
                          color: Color.fromRGBO(27, 87, 161, 1),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool isObscure = false,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color.fromARGB(255, 4, 97, 137))),
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: const Color.fromARGB(255, 4, 97, 137)),
          border: InputBorder.none,
          prefixIcon: Icon(prefixIcon),
        ),
      ),
    );
  }

  Widget buildMaterialButton({
    required VoidCallback onPressed,
    required String text,
    required Color color,
  }) {
    return MaterialButton(
      onPressed: onPressed,
      height: 50,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _onLoginPressed(BuildContext context) {
    if (emailController.text == correoEjemplo &&
        passwordController.text == contrasenaEjemplo) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UsersPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Usuario o contraseña incorrectos'),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
