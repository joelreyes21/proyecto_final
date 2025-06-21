import 'package:flutter/material.dart';

class AgregarProductoScreen extends StatefulWidget {
  const AgregarProductoScreen({super.key});

  @override
  State<AgregarProductoScreen> createState() => _AgregarProductoScreenState();
}

class _AgregarProductoScreenState extends State<AgregarProductoScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  String? imagenSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F2),
      appBar: AppBar(
        title: const Text('Agregar Producto'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(nombreController, 'Nombre del producto'),
            const SizedBox(height: 16),
            _buildTextField(descripcionController, 'Descripción'),
            const SizedBox(height: 16),
            _buildTextField(precioController, 'Precio', inputType: TextInputType.number),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text("Seleccionar imagen"),
              onPressed: () {
                setState(() {
                  imagenSeleccionada = 'assets/ejemplo.png'; // Simulado
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade100,
                foregroundColor: Colors.deepPurple.shade800,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 0,
              ),
            ),
            if (imagenSeleccionada != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Imagen seleccionada: $imagenSeleccionada",
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                final nombre = nombreController.text.trim();
                final descripcion = descripcionController.text.trim();
                final precio = precioController.text.trim();

                if (nombre.isEmpty || descripcion.isEmpty || precio.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Completa todos los campos')),
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ Producto agregado (pendiente guardar en backend)')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Guardar producto', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType inputType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
