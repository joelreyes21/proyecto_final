import 'package:flutter/material.dart';
import '../utils/carrito.dart';
import '../models/producto.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final productos = Carrito.obtenerTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tu carrito"),
        backgroundColor: Colors.brown[700],
      ),
      body: productos.isEmpty
          ? const Center(child: Text("🛒 Tu carrito está vacío"))
          : ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return ListTile(
                  leading: Image.asset(producto.imagen, width: 50, height: 50),
                  title: Text(producto.nombre),
                  subtitle: Text(producto.precio),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        Carrito.eliminar(producto);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${producto.nombre} eliminado")),
                      );
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: productos.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Acción futura: pagar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text("Total: \$${Carrito.total().toStringAsFixed(2)}"),
              ),
            ),
    );
  }
}
