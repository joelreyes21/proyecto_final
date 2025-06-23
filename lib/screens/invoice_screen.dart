import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/carrito.dart';
import '../models/producto.dart';
import 'home.dart';
import '../utils/globals.dart'; // 👈 se importa el ID global

class InvoiceScreen extends StatelessWidget {
  final List<Producto> productos;
  final double total;
  final DateTime fecha;

  const InvoiceScreen({
    super.key,
    required this.productos,
    required this.total,
    required this.fecha,
  });

  Future<void> _guardarFactura(BuildContext context) async {
        const String baseUrl = 'http://192.168.0.8:3000'; // ✅
        final Uri uri = Uri.parse('$baseUrl/api/facturas/crear');

    // Prepara los productos que se enviarán
    final items = productos.map((p) {
      return {
        'nombre': p.nombre,
        'cantidad': p.cantidad,
        'precio': double.tryParse(p.precio.replaceAll('\$', '')) ?? 0.0,
      };
    }).toList();

    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usuario_id': usuarioGlobalId, // 👈 ahora usa el ID del usuario logueado
        'fecha': fecha.toIso8601String(),
        'total': total,
        'items': items,
      }),
    );

    if (res.statusCode == 201 || res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Factura guardada')),
      );
      Carrito.limpiar();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(
            isLogin: true,
            mesa: 0,
          ),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error al guardar factura: ${res.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Factura'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,

      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Factura de Compra',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Fecha: ${fecha.toString().split(' ')[0]}'),
            const Divider(height: 32),
            const Text('Productos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (_, i) {
                  final p = productos[i];
                  return ListTile(
                    leading: Image.asset(p.imagen, width: 50),
                    title: Text(p.nombre),
                    subtitle: Text('Cantidad: ${p.cantidad}'),
                    trailing: Text(p.precio),
                  );
                },
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Total: \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _guardarFactura(context),
                icon: const Icon(Icons.check),
                label: const Text('Confirmar compra'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,

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
