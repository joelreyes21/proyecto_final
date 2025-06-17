import 'package:flutter/material.dart';
import 'home.dart'; // ✅ Importamos home.dart para navegar

class SelectTableScreen extends StatelessWidget {
  final bool isLogin; // ✅ Recibimos este valor desde login_signup.dart

  const SelectTableScreen({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    final List<int> mesas = List.generate(11, (index) => index + 1); // Mesas 1 a 11

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona tu mesa'),
        backgroundColor: Colors.brown[700],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              '¿En qué mesa te encuentras?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Grid de mesas
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: mesas.map((numeroMesa) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[200],
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(
                            isLogin: isLogin,
                            mesa: numeroMesa, // ✅ enviamos la mesa seleccionada
                          ),
                        ),
                      );
                    },
                    child: Text(
                      '$numeroMesa',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // Opción delivery
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomeScreen(
                      isLogin: isLogin,
                      mesa: 0, // ✅ Delivery lo representamos como mesa 0
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              icon: const Icon(Icons.delivery_dining),
              label: const Text(
                'Quiero Delivery',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
