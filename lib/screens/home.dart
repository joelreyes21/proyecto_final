import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/gestion_usuarios.dart';
import 'product_details.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'facturas_screen.dart';
import '../utils/globals.dart' as globals;
import 'login_signup.dart';
import 'gestion_producto.dart';
import 'staff_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List<Map<String, dynamic>> productosGlobales = [];
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    fetchProductos();
    _screens.add(_buildHomeBody());
    if (globals.usuarioGlobalRoleId == 1 || globals.usuarioGlobalRoleId == 2) {
      _screens.add(const StaffScreen());
    }
    _screens.add(const PerfilScreen());
  }

  Future<void> fetchProductos() async {
    final url = Uri.parse('http://192.168.0.8:3000/api/productos');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          productosGlobales = data.map<Map<String, dynamic>>((p) => {
            'nombre': p['nombre'],
            'descripcion': p['descripcion'],
            'precio': "\$${p['precio']}",
            'imagen': 'assets/default.png',
            'categoria': p['categoria']?['nombre'] ?? 'Sin categoría',
          }).toList();
        });
      }
    } catch (e) {
      print('Error al obtener productos: $e');
    }
  }

  void _agregarProducto(Map<String, dynamic> producto) {
    setState(() {
      productosGlobales.add(producto);
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _buildHomeBody() {
    final productosFiltrados = productosGlobales.where((producto) =>
      (selectedCategory == 'All' || producto['categoria'] == selectedCategory) &&
      producto['nombre'].toLowerCase().contains(searchTerm.toLowerCase())).toList();

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
                          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.local_cafe, size: 50),
                              const SizedBox(height: 10),
                              Text(producto['nombre'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(producto['precio']),
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

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(decoration: const BoxDecoration(color: Colors.black), child: const Center(child: Text('Bienvenido', style: TextStyle(color: Colors.white)))),
        ListTile(leading: const Icon(Icons.person), title: const Text('Perfil'), onTap: () => _onItemTapped(globals.usuarioGlobalRoleId == 1 || globals.usuarioGlobalRoleId == 2 ? 2 : 1)),
        if (globals.usuarioGlobalRoleId == 1 || globals.usuarioGlobalRoleId == 2)
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Gestión de productos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GestionProductosScreen(
                    onProductoAgregado: (nuevoProducto) {
                      if (nuevoProducto != null) {
                        _agregarProducto(nuevoProducto);
                      }
                    },
                  ),
                ),
              ).then((resultado) {
                if (resultado == true) {
                  fetchProductos();
                }
              });
            },
          ),
        ListTile(leading: const Icon(Icons.receipt_long), title: const Text('Facturas'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FacturasScreen()))),
        if (globals.usuarioGlobalRoleId == 1 || globals.usuarioGlobalRoleId == 2)
          ListTile(leading: const Icon(Icons.local_shipping), title: const Text('Órdenes activas'), onTap: () {}),
        ListTile(leading: const Icon(Icons.payment), title: const Text('Métodos de pago'), onTap: () {}),
        if (globals.usuarioGlobalRoleId == 1)
          ListTile(leading: const Icon(Icons.group), title: const Text('Gestión de usuarios'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GestionUsuariosScreen()))),
        ListTile(leading: const Icon(Icons.star), title: const Text('Favoritos'), onTap: () {}),
        const Divider(),
        ListTile(leading: const Icon(Icons.logout, color: Colors.red), title: const Text('Cerrar sesión', style: TextStyle(color: Colors.red)), onTap: () {
          globals.usuarioGlobalId = null;
          globals.usuarioGlobalRoleId = null;
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginSignUpScreen()), (route) => false);
        }),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildDrawer(),
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black), actions: [
        IconButton(icon: const Icon(Icons.shopping_cart, color: Colors.black), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()))),
      ]),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          if (globals.usuarioGlobalRoleId == 1 || globals.usuarioGlobalRoleId == 2)
            const BottomNavigationBarItem(icon: Icon(Icons.engineering), label: 'Staff'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
