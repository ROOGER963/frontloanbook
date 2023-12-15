import 'package:flutter/material.dart';
import 'package:frontloanbook/pages/home_page.dart';
import 'package:frontloanbook/pages/login_page.dart';
import 'package:frontloanbook/pages/widgets/create_book.dart';
import 'package:frontloanbook/pages/widgets/create_loan.dart';


class MenuLateral extends StatelessWidget {
  const MenuLateral({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina Principal'),
        backgroundColor: Color.fromRGBO(27, 87, 161, 1),
      ),
      body: Center(
        child: Text('Menu unido a proyecto'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Bryan Latacumba'),
              accountEmail: Text('bsm.latacumba@yavirac.edu.ec'),
              currentAccountPicture: CircleAvatar(
                foregroundImage: AssetImage('images/roger.jpg'),
              ),
              otherAccountsPictures: [
                CircleAvatar(
                  foregroundImage: AssetImage('images/perfil.jpg'),
                )
              ],
              decoration:
                  BoxDecoration(color: Color.fromARGB(213, 8, 100, 149)),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return HomePage();
                  },
                );
                // Puedes navegar a la pantalla de libros o realizar alguna acción al presionar el botón
                print("Presionaste el botón de Libros");
              },
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text('Libros'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Muestra el widget de CrearActualizarEliminar al presionar el botón
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CreateBookLoan();
                  },
                );
              },
              child: ListTile(
                leading: Icon(Icons.bookmark_add),
                title: Text('Crear Libros'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Muestra el widget de CrearActualizarEliminar al presionar el botón
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CreateLoanrWidget();
                  },
                );
              },
              child: ListTile(
                leading: Icon(Icons.add_task),
                title: Text('Prestamos'),
              ),
            ),
            SizedBox(height: 350),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text('Cerrar Sesión'),
              onTap: () {
                // Navegar a HomePage y reemplazar la página actual
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}