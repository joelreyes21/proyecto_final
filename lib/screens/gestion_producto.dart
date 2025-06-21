import 'package:flutter/material.dart';
import 'agregar_producto_screen.dart'; // ✅ IMPORTANTE

class GestionProductosScreen extends StatelessWidget {
  const GestionProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Productos'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.brown[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const Text(
              'Administrá los productos disponibles en tu tienda.',
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 10, 10, 10)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildCard(
                  context,
                  icon: Icons.add_box,
                  color: Colors.green,
                  label: 'Agregar',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AgregarProductoScreen()),
                    );
                  },
                ),
                _buildCard(
                  context,
                  icon: Icons.edit,
                  color: Colors.orange,
                  label: 'Editar',
                  onTap: () {},
                ),
                _buildCard(
                  context,
                  icon: Icons.delete,
                  color: Colors.red,
                  label: 'Eliminar',
                  onTap: () {},
                ),
                _buildCard(
                  context,
                  icon: Icons.list_alt,
                  color: Colors.blueGrey,
                  label: 'Ver todos',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required IconData icon, required Color color, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
