import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/gestion_usuarios.dart';
import 'product_details.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'facturas_screen.dart';
import '../utils/globals.dart';
import 'login_signup.dart';
import '../models/producto.dart';
import '../utils/carrito.dart';
import 'gestion_producto.dart';
import 'staff_screen.dart';

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
  int _selectedIndex = 0;

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

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      _buildHomeBody(),
      const StaffScreen(),
      const PerfilScreen(),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _buildHomeBody() {
    final productosFiltrados = productos
        .where((producto) =>
            (selectedCategory == 'All' || producto['categoria'] == selectedCategory) &&
            producto['nombre'].toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

    return Padding(
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
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    producto['precio'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: const Icon(Icons.add_shopping_cart, size: 20),
                                  onPressed: () {
                                    Carrito.agregar(
                                      Producto(
                                        nombre: producto['nombre'],
                                        precio: producto['precio'],
                                        imagen: producto['imagen'],
                                        descripcion: producto['descripcion'],
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("\u{1F6D2} Producto agregado al carrito")),
                                    );
                                  },
                                ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildDrawer(),
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
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.engineering), label: 'Staff'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
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
            onTap: () => _onItemTapped(2),
          ),
          if (usuarioGlobalRoleId == 1 || usuarioGlobalRoleId == 2)
            ListTile(
              leading: const Icon(Icons.settings_suggest),
              title: const Text('Gestión de productos'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const GestionProductosScreen()));
              },
            ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Facturas'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const FacturasScreen()));
            },
          ),
          if (usuarioGlobalRoleId == 1 || usuarioGlobalRoleId == 2)
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Órdenes activas'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const FacturasScreen()));
              },
            ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Métodos de pago'),
            onTap: () {},
          ),
          if (usuarioGlobalRoleId == 1 || usuarioGlobalRoleId == 2)
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Gestión de usuarios'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const GestionUsuariosScreen()));
              },
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
              usuarioGlobalId = null;
              usuarioGlobalRoleId = null;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginSignUpScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
