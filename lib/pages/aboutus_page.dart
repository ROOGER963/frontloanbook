import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BonitaPantalla extends StatefulWidget {
  @override
  _BonitaPantallaState createState() => _BonitaPantallaState();
}

class _BonitaPantallaState extends State<BonitaPantalla> {
  bool isHovered1 = false;
  bool isHovered2 = false;

  List<String> imagesMision = [
    'images/negocio1.jpg',
    'images/negocio2.jpg',
    'images/negocio3.jpg',
    'images/negocio4.jpg',
  ];

  List<String> imagesVision = [
    'images/Socio1.jpg',
    'images/Socio2.jpg',
    'images/Socio3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 184, 231, 255),
                Color.fromARGB(255, 224, 229, 248),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      isHovered1 = value;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        'Misión',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: isHovered1
                              ? LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.lightBlue.shade200,
                                    const Color.fromARGB(255, 255, 255, 255),
                                  ],
                                )
                              : LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.blue.shade200,
                                    Colors.blue.shade400,
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Ofrecer un sistema de gestión de préstamos de libros sencillo, accesible y seguro para cafeteras, eventos, estanterías portátiles u otros negocios pequeños.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 20),
                      CarouselSlider(
                        items: imagesMision.map((image) {
                          return Image.asset(
                            image,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      isHovered2 = value;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        'Visión',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: isHovered2
                              ? LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.lightBlue.shade200,
                                    const Color.fromARGB(255, 255, 255, 255),
                                  ],
                                )
                              : LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.blue.shade200,
                                    Colors.blue.shade400,
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Ser el líder en la gestión de préstamos de libros para negocios pequeños, proporcionando un servicio que sea fácil de usar, asequible y que satisfaga las necesidades de nuestros clientes.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 20),
                      CarouselSlider(
                        items: imagesVision.map((image) {
                          return Image.asset(
                            image,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}