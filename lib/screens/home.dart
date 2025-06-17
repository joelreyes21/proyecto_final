import 'package:flutter/material.dart';
import 'product_details.dart';

class HomeScreen extends StatelessWidget {
  final bool isLogin;
  final int mesa;

  const HomeScreen({super.key, required this.isLogin, required this.mesa});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> productos = [
      {
        'nombre': 'Expresso macchiato',
        'precio': '\$3.70',
        'imagen': 'assets/espresso.png',
        'descripcion': 'Un espresso fuerte con un toque de leche espumada.',
      },
      {
        'nombre': 'Té chai',
        'precio': '\$6.20',
        'imagen': 'assets/te.png',
        'descripcion': 'Té con especias y leche, ideal para tardes frías.',
      },
      {
        'nombre': 'Té chai',
        'precio': '\$6.20',
        'imagen': 'assets/te.png',
        'descripcion': 'Té con especias y leche, ideal para tardes frías.',
      },
      {
        'nombre': 'Té chai',
        'precio': '\$6.20',
        'imagen': 'assets/te.png',
        'descripcion': 'Té con especias y leche, ideal para tardes frías.',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What's for a drink\ntoday?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              mesa == 0 ? 'Modo: Delivery' : 'Mesa #$mesa',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 20),

            // Buscador
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Sear_ch",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Categorías
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  "Hot Drinks",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                Text("Cold Drinks", style: TextStyle(color: Colors.grey)),
                Text("Pastries", style: TextStyle(color: Colors.grey)),
                Text("Sandwiches", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 20),

            // Grid de productos
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
                children: productos.map((producto) {
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
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              producto['imagen'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            producto['nombre'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            producto['precio'],
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
