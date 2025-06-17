import 'package:flutter/material.dart';

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
        title: Text(nombre),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagen, height: 200),
            const SizedBox(height: 20),
            Text(
              nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              precio,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              descripcion,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
