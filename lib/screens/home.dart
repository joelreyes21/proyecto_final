import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final bool isLogin;
  final int mesa;

  const HomeScreen({
    super.key,
    required this.isLogin,
    required this.mesa,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> productos = [
      {
        'nombre': 'Expresso macchiato',
        'precio': '\$3.70',
        'imagen': 'assets/espresso.png',
        'descripcion': 'Café intenso con un toque de leche espumada.',
      },
      {
        'nombre': 'Té chai',
        'precio': '\$6.20',
        'imagen': 'assets/te.png',
        'descripcion': 'Té especiado con leche, al estilo hindú.',
      },
      {
        'nombre': 'Té chai',
        'precio': '\$6.20',
        'imagen': 'assets/te.png',
        'descripcion': 'Té especiado con leche, al estilo hindú.',
      },
      {
        'nombre': 'Té chai',
        'precio': '\$6.20',
        'imagen': 'assets/te.png',
        'descripcion': 'Té especiado con leche, al estilo hindú.',
      },
    ];

    final String mesaTexto = mesa == 0 ? 'Delivery 🛵' : 'Mesa #$mesa';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.menu, color: Colors.black),
            Text(
              mesaTexto,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const Icon(Icons.shopping_cart, color: Colors.black),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const Text(
              "What's for a drink\ntoday?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Búsqueda
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
            // Tabs
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
            // Productos
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: productos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final producto = productos[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
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
                      const SizedBox(height: 10),
                      Text(
                        producto['nombre'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        producto['precio'],
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
