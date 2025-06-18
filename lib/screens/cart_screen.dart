import 'package:flutter/material.dart';
import '../utils/carrito.dart';
import '../models/producto.dart';
import 'invoice_screen.dart'; // Asegúrate de tener esta pantalla creada

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
                return Dismissible(
                  key: Key(producto.nombre),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      Carrito.eliminar(producto);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${producto.nombre} eliminado")),
                    );
                  },
                  child: ListTile(
                    leading: Image.asset(producto.imagen, width: 50, height: 50),
                    title: Text(producto.nombre),
                    subtitle: Text(producto.precio),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InvoiceScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text("Pagar: \$${Carrito.total().toStringAsFixed(2)}"),
              ),
            ),
    );
  }
}
