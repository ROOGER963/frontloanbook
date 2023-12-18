import 'package:flutter/material.dart';
import 'package:frontloanbook/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var d = const Duration(seconds: 10);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>  HomeScreen()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(70),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    titleTextStyle: TextStyle(color: Colors.white),
                    title: Text(
                      "Medical App",
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      "Bienvenido a la app",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(
                    color: Color.fromARGB(255, 63, 81, 181),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
