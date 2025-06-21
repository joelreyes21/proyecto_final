import 'package:flutter/material.dart';
import '../utils/carrito.dart';
import '../models/producto.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String nombre;
  final String precio;
  final String imagen;
  final String descripcion;

  const ProductDetailsScreen({
    super.key,
    required this.nombre,
    required this.precio,
    required this.imagen,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles del producto"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(imagen, fit: BoxFit.contain),
            ),
            const SizedBox(height: 20),
            Text(
              nombre,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              precio,
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),
            Text(
              descripcion,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Carrito.agregar(Producto(
                  nombre: nombre,
                  precio: precio,
                  imagen: imagen,
                ));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Producto agregado al carrito")),
                );
              },
              icon: const Icon(Icons.shopping_cart_checkout),
              label: const Text("Agregar al carrito") ,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 11, 11, 11),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
