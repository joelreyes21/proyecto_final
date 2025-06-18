import 'package:flutter/material.dart';
import 'product_details.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isLogin;
  final int mesa;

  const HomeScreen({super.key, required this.isLogin, required this.mesa});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  String searchTerm = '';

  final List<Map<String, dynamic>> productos = [
    {
      'nombre': 'Expresso macchiato',
      'precio': '\$3.70',
      'imagen': 'assets/espresso.png',
      'descripcion': 'Un espresso fuerte con un toque de leche espumada.',
      'categoria': 'Hot Drinks',
    },
    {
      'nombre': 'Té chai',
      'precio': '\$6.20',
      'imagen': 'assets/te.png',
      'descripcion': 'Té con especias y leche, ideal para tardes frías.',
      'categoria': 'Hot Drinks',
    },
    {
      'nombre': 'Granita de café',
      'precio': '\$4.50',
      'imagen': 'assets/granita.png',
      'descripcion': 'Café helado con textura granulada, refrescante.',
      'categoria': 'Cold Drinks',
    },
    {
      'nombre': 'Tiramisu',
      'precio': '\$4.50',
      'imagen': 'assets/tiramisu.png',
      'descripcion': 'Postre italiano con café y mascarpone.',
      'categoria': 'Pastries',
    },
    {
      'nombre': 'Sandwich',
      'precio': '\$4.50',
      'imagen': 'assets/sandwich.png',
      'descripcion': 'Sándwich clásico con ingredientes frescos.',
      'categoria': 'Sandwiches',
    },
    {
      'nombre': 'Sandwich de queso',
      'precio': '\$4.50',
      'imagen': 'assets/sandwich_cheese.png',
      'descripcion': 'Sándwich relleno de queso derretido.',
      'categoria': 'Sandwiches',
    },
    {
      'nombre': 'Chocolate lasagna',
      'precio': '\$4.50',
      'imagen': 'assets/chocolate_lasagna.png',
      'descripcion': 'Postre de chocolate en capas tipo lasagna.',
      'categoria': 'Pastries',
    },
    {
      'nombre': 'Strawberry shortcake',
      'precio': '\$4.50',
      'imagen': 'assets/strawberryshortcake.png',
      'descripcion': 'Pastel suave con crema y fresas frescas.',
      'categoria': 'Pastries',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final productosFiltrados = productos
        .where((producto) =>
            (selectedCategory == 'All' || producto['categoria'] == selectedCategory) &&
            producto['nombre']
                .toLowerCase()
                .contains(searchTerm.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.brown),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(radius: 30, backgroundColor: Colors.white),
                  SizedBox(height: 10),
                  Text('Bienvenido', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historial de pedidos'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Facturas'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Métodos de pago'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Favoritos'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("What's for a drink\ntoday?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.mesa == 0 ? 'Modo: Delivery' : 'Table #${widget.mesa}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
              child: TextField(
                onChanged: (value) => setState(() => searchTerm = value),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['All', 'Hot Drinks', 'Cold Drinks', 'Pastries', 'Sandwiches'].map((cat) {
                final selected = cat == selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => selectedCategory = cat),
                  child: Text(
                    cat,
                    style: TextStyle(
                      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      color: selected ? Colors.black : Colors.grey,
                      decoration: selected ? TextDecoration.underline : TextDecoration.none,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: productosFiltrados.isEmpty
                  ? const Center(child: Text("No hay productos"))
                  : GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                      children: productosFiltrados.map((producto) {
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
                            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    producto['imagen'],
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(producto['nombre'], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 4),
                                Text(producto['precio'], style: const TextStyle(fontSize: 14)),
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
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.add_business), label: 'Staff'),
        ],
      ),
    );
  }
}
