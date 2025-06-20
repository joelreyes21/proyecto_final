import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final bool isLogin;
  const HomeScreen({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> productos = [
      {
        'nombre': 'Expresso macchiato',
        'precio': '\$3.70',
        'imagen': 'assets/espresso.png',
      },
      {
        'nombre': 'Té chai',
        'precio': '\$6.20',
        'imagen': 'assets/te.png',
      },
      {
        'nombre': 'Té chai',
        'precio': '\$6.20',
        'imagen': 'assets/te.png',
      },
      {
        'nombre': 'Expresso macchiato',
        'precio': '\$3.70',
        'imagen': 'assets/espresso.png',
      },
      {
        'nombre': 'Té chai',
        'precio': '\$6.20',
        'imagen': 'assets/te.png',
      },
      {
        'nombre': 'Expresso macchiato',
        'precio': '\$3.70',
        'imagen': 'assets/espresso.png',
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
        padding: const EdgeInsets.symmetric(horizontal: 20), // corregido
        child: ListView(
          children: [
            const Text(
              "What's for a drink\ntoday?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Campo de búsqueda
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Sear_ch", // corregido (opcional poner real "Search...")
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Tabs horizontales
            SingleChildScrollView( // corregido
              scrollDirection: Axis.horizontal, // corregido
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Hot Drinks", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Cold Drinks", style: TextStyle(color: Colors.grey)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Pastries", style: TextStyle(color: Colors.grey)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Sandwiches", style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Grid de productos (2 columnas) // corregido
            GridView.count(
  crossAxisCount: 2,
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  childAspectRatio: 0.75, // ✅ corregido: da más alto a cada card
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  children: productos.map((producto) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // ✅ corregido
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              producto['imagen'],
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            producto['nombre'],
            textAlign: TextAlign.center,
            maxLines: 1, // ✅ corregido: evita texto muy largo
            overflow: TextOverflow.ellipsis, // ✅ agregamos puntos suspensivos
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            producto['precio'],
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }).toList(),
),

            const SizedBox(height: 20),
          ],
        ),
      ),
      // Barra inferior
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        onTap: (index) {
          // acción futura
        },
      ),
    );
  }
}
