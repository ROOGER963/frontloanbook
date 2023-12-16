import 'package:flutter/material.dart';
import 'package:frontloanbook/pages/inicio_page.dart';
import 'package:frontloanbook/pages/login_page.dart';
import 'package:frontloanbook/pages/widgets/create_book.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Principal'),
        backgroundColor: Color.fromRGBO(30, 63, 104, 1),
      ),
      body: Center(
        child: Text(
          'Menú unido a proyecto',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromRGBO(1, 20, 31, 1), // Fondo del Drawer
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  'Bryan Latacumba',
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: Text(
                  'bsm.latacumba@yavirac.edu.ec',
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  foregroundImage: AssetImage('images/profile.png'),
                ),
                otherAccountsPictures: [
                  CircleAvatar(
                    foregroundImage: AssetImage('images/perfil.jpg'),
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.bookmark_add, color: Colors.white),
                title: Text(
                  'Crear Libros',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Acción al tocar el elemento
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CreateBookLoan();
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.add_task, color: Colors.white),
                title: Text(
                  'Préstamos',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Acción al tocar el elemento
                },
              ),
              SizedBox(height: 350),
              Divider(color: Colors.white),
              ListTile(
                leading: Icon(Icons.cancel, color: Colors.white),
                title: Text(
                  'Cerrar Sesión',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navegar a HomePage y reemplazar la página actual
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => InicioPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}