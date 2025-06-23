import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/producto.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class FacturaPdfScreen extends StatefulWidget {
  final int facturaId;
  final DateTime fecha;
  final double total;

  const FacturaPdfScreen({
    super.key,
    required this.facturaId,
    required this.fecha,
    required this.total,
  });

  @override
  State<FacturaPdfScreen> createState() => _FacturaPdfScreenState();
}

class _FacturaPdfScreenState extends State<FacturaPdfScreen> {
  late Future<List<Producto>> _productos;

  @override
  void initState() {
    super.initState();
    _productos = _cargarProductosFactura();
  }

  Future<List<Producto>> _cargarProductosFactura() async {
    final uri = Uri.parse(
        'http://192.168.0.8:3000/api/facturas/${widget.facturaId}/detalles');

    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Error al obtener productos');
    }

    final List<dynamic> data = jsonDecode(res.body);
    return data.map((p) {
      return Producto(
        nombre: p['nombre'] ?? '',
        precio: '\$${p['precio'].toString()}',
        imagen: '',
        cantidad: p['cantidad'] ?? 1,
      );
    }).toList();
  }

  Future<void> _generarPDF(List<Producto> productos) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Factura #${widget.facturaId}',
                style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text('Fecha: ${widget.fecha.toLocal().toString().split(" ")[0]}'),
            pw.SizedBox(height: 20),
            pw.Text('Productos:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            if (productos.isEmpty)
              pw.Text('No se encontraron productos.')
            else
              ...productos.map(
                (p) => pw.Text('${p.nombre} x${p.cantidad} - ${p.precio}'),
              ),
            pw.Divider(),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text('Total: \$${widget.total.toStringAsFixed(2)}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            )
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Factura"),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,

      ),
      body: FutureBuilder<List<Producto>>(
        future: _productos,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final productos = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Factura de Compra",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("Fecha: ${widget.fecha.toLocal().toString().split(' ')[0]}"),
                const SizedBox(height: 20),
                const Text("Productos:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: productos.isEmpty
                      ? const Center(child: Text("No hay productos en esta factura"))
                      : ListView.builder(
                          itemCount: productos.length,
                          itemBuilder: (_, i) {
                            final p = productos[i];
                            return ListTile(
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
                  child: Text("Total: \$${widget.total.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => _generarPDF(productos),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("Generar PDF"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 208, 55, 55),
                      foregroundColor: Colors.white,

                      padding:
                          const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
