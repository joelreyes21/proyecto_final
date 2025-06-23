import 'package:flutter/material.dart';
import 'agregar_producto_screen.dart';

class GestionProductosScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) onProductoAgregado;

  const GestionProductosScreen({super.key, required this.onProductoAgregado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestión de Productos")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCard(context, icon: Icons.add_box, color: Colors.green, label: 'Agregar', onTap: () async {
              final nuevoProducto = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AgregarProductoScreen()),
              );

              if (nuevoProducto != null && nuevoProducto is Map<String, dynamic>) {
                onProductoAgregado(nuevoProducto);
                Navigator.pop(context, true); 
              }
            }),
            _buildCard(context, icon: Icons.edit, color: Colors.orange, label: 'Editar'),
            _buildCard(context, icon: Icons.delete, color: Colors.red, label: 'Eliminar'),
            _buildCard(context, icon: Icons.list, color: Colors.blue, label: 'Ver todos'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required IconData icon, required Color color, required String label, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 48, color: color),
          const SizedBox(height: 12),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
