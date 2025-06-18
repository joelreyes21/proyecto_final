import 'package:flutter/material.dart';

class FacturasScreen extends StatelessWidget {
  const FacturasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facturas'),
        backgroundColor: Colors.brown,
      ),
      body: const Center(
        child: Text(
          'Aquí se mostrarán tus facturas',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
