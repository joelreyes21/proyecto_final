import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AgregarProductoScreen extends StatefulWidget {
  const AgregarProductoScreen({super.key});

  @override
  State<AgregarProductoScreen> createState() => _AgregarProductoScreenState();
}

class _AgregarProductoScreenState extends State<AgregarProductoScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  String categoriaSeleccionada = 'Hot Drinks';
  File? imagenSeleccionada;

  Future<void> seleccionarImagen() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imagenSeleccionada = File(picked.path);
      });
    }
  }

  Future<void> guardarProducto() async {
    final nombre = nombreController.text.trim();
    final descripcion = descripcionController.text.trim();
    final precio = precioController.text.trim();

    if (nombre.isEmpty || descripcion.isEmpty || precio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.8:3000/api/productos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': nombre,
          'descripcion': descripcion,
          'precio': precio,
          'cantidad': 1,
          'categoria': categoriaSeleccionada,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Producto guardado')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar el producto')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error de red')),
      );
    }
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType type = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const Text("Agregar Producto"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(nombreController, 'Nombre del producto'),
            const SizedBox(height: 16),
            _buildTextField(descripcionController, 'Descripción'),
            const SizedBox(height: 16),
            _buildTextField(precioController, 'Precio', type: TextInputType.number),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: categoriaSeleccionada,
              decoration: InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: ['Hot Drinks', 'Cold Drinks', 'Desserts', 'Sandwiches']
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) => setState(() => categoriaSeleccionada = value!),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              onPressed: seleccionarImagen,
              icon: const Icon(Icons.image),
              label: const Text('Seleccionar imagen (solo vista previa)'),
            ),
            if (imagenSeleccionada != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    Text('Imagen: ${imagenSeleccionada!.path.split('/').last}', style: const TextStyle(fontSize: 13)),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(imagenSeleccionada!, width: 100, height: 100, fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: guardarProducto,
              child: const Center(child: Text('Guardar Producto', style: TextStyle(fontSize: 16))),
            ),
          ],
        ),
      ),
    );
  }
}
