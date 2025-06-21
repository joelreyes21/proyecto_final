import 'package:flutter/material.dart';
import '../utils/carrito.dart';
import '../models/producto.dart';
import 'invoice_screen.dart';

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
        title: const Text('Tu carrito'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: productos.isEmpty
          ? const Center(child: Text('🛒 Tu carrito está vacío'))
          : ListView.builder(
              itemCount: productos.length,
              itemBuilder: (_, i) {
                final p = productos[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Image.asset(p.imagen, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(p.nombre),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.precio),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  Carrito.quitarUnidad(p);
                                });
                              },
                            ),
                            Text('${p.cantidad}', style: const TextStyle(fontSize: 16)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() {
                                  Carrito.agregar(p);
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() => Carrito.eliminar(p));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${p.nombre} eliminado')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: productos.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InvoiceScreen(
                        productos: List<Producto>.from(productos),
                        total: Carrito.total(),
                        fecha: DateTime.now(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Pagar: \$${Carrito.total().toStringAsFixed(2)}'),
              ),
            ),
    );
  }
}
