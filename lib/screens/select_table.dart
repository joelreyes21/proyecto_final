import 'package:flutter/material.dart';
import 'product_details.dart'; // Asegúrate que exista esta pantalla si estás usando detalles

class HomeScreen extends StatelessWidget {
  final bool isLogin;
  final int mesa; // ✅ Recibimos número de mesa

  const HomeScreen({super.key, required this.isLogin, required this.mesa});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> productos = [
      {
        'nombre': 'Espresso macchiato',
        'precio': '\$3.70',
        'imagen': 'assets/espresso.png',
        'descripcion': 'Un espresso fuerte con una pequeña capa de leche espumada.',
      },
      {
        'nombre': 'Té chai',
        'precio': '\$6.50',
        'imagen': 'assets/te.png',
        'descripcion': 'Infusión especiada con leche, típica de la India.',
      },
      {
        'nombre': 'Granita de café',
        'precio': '\$4.90',
        'imagen': 'assets/granita.png',
        'descripcion': 'Bebida fría granulada perfecta para el calor.',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            // ✅ Número de mesa elegante
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.brown.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  mesa == 0 ? 'Delivery' : 'Mesa #$mesa',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "What's for a drink\ntoday?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search drink...",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("Hot Drinks", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                Text("Cold Drinks", style: TextStyle(color: Colors.grey)),
                Text("Pastries", style: TextStyle(color: Colors.grey)),
                Text("Sandwiches", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                            nombre: producto['nombre'],
                            precio: producto['precio'],
                            imagen: producto['imagen'],
                            descripcion: producto['descripcion'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              producto['imagen'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            producto['nombre'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            producto['precio'],
                            style: const TextStyle(color: Color.fromARGB(248, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
