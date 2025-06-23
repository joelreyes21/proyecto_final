import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/factura.dart';
import 'factura_pdf_screen.dart';
import '../utils/globals.dart'; // NUEVO

class FacturasScreen extends StatefulWidget {
  const FacturasScreen({super.key});

  @override
  State<FacturasScreen> createState() => _FacturasScreenState();
}

class _FacturasScreenState extends State<FacturasScreen> {
  late Future<List<Factura>> _futureFacturas;

  @override
  void initState() {
    super.initState();
    _futureFacturas = _fetchFacturas();
  }

  Future<List<Factura>> _fetchFacturas() async {
    final baseUrl = 'http://192.168.0.8:3000';
    final uri = Uri.parse('$baseUrl/api/facturas/usuario/$usuarioGlobalId');

    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Error al cargar facturas: ${res.statusCode}');
    }

    final List<dynamic> data = jsonDecode(res.body);
    return data.map((j) => Factura.fromJson(j)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facturas'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,

      ),
      body: FutureBuilder<List<Factura>>(
        future: _futureFacturas,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }

          final facturas = snap.data!;
          if (facturas.isEmpty) {
            return const Center(child: Text('No tienes facturas aún'));
          }

          return ListView.builder(
            itemCount: facturas.length,
            itemBuilder: (ctx, i) {
              final f = facturas[i];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FacturaPdfScreen(
                        facturaId: f.id,
                        total: f.total,
                        fecha: f.fecha,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Factura #${f.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Fecha: ${f.fecha.toLocal().toString().split(" ")[0]}'),
                      Text('Total: \$${f.total.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
