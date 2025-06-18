import 'package:flutter/material.dart';
import '../utils/carrito.dart';
import '../models/producto.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Producto> productos = Carrito.obtenerTodos();
    final double total = Carrito.total();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Factura'),
        backgroundColor: Colors.brown[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Factura de Compra',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Fecha: ${DateTime.now().toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(height: 30),

            const Text(
              'Productos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return ListTile(
                    leading: Image.asset(producto.imagen, width: 50, height: 50),
                    title: Text(producto.nombre),
                    subtitle: Text(producto.precio),
                  );
                },
              ),
            ),

            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total a pagar: \$${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gracias por tu compra ❤️')),
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Carrito.limpiar();
                },
                icon: const Icon(Icons.check),
                label: const Text('Confirmar compra'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
