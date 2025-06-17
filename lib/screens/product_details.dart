import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../utils/carrito.dart';


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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(nombre),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Imagen del producto
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imagen,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Nombre
              Text(
                nombre,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Precio
              Text(
                precio,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              // Descripción
              Text(
                descripcion,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),

              // Botón
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Agregado al carrito ✅")),
                  );
                },
                icon: const Icon(Icons.shopping_cart_checkout),
                label: const Text("Agregar al carrito"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
