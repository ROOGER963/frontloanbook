import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontloanbook/pages/home_screen.dart';
import 'package:frontloanbook/pages/login_page.dart';
import 'favoritos_page.dart';
import 'aboutus_page.dart';
import 'admin/users_page.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  int _selectedTab = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    FavoritosPage(),
    AboutUsPAge(),
    LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: Container(
        child: _pages[_selectedTab],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedTab,
        height: 60,
        items: <Widget>[
          _builNavItem(Icons.auto_stories_outlined, _selectedTab == 0),
          _builNavItem(Icons.favorite, _selectedTab == 1),
          _builNavItem(Icons.data_usage_sharp, _selectedTab == 2),
          _builNavItem(Icons.login, _selectedTab == 3),
       
        ],
        //color de la barra de navegacion
        color: const Color.fromRGBO(63, 81, 181, 1),
        //Color de fondo de iconos
        buttonBackgroundColor: Color.fromARGB(255, 170, 175, 175),
        //Color de fondo detras de la barra
        backgroundColor: Colors.transparent,
        //curva de animacion
        animationCurve: Curves.easeInOut,
        //duracion de la animacion
        animationDuration: Duration(milliseconds: 300),
        onTap: (index){
          setState(() {
            _selectedTab = index;
          });
        }
      ),
    );
  }
  Widget _builNavItem (IconData icon, bool isSelected){
    return Icon(icon,size: 30, color: isSelected ? Color.fromARGB(255, 7, 6, 18) : Color.fromARGB(255, 1, 23, 53), );
  }
}
