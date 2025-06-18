import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imagen;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final seleccion = await picker.pickImage(source: ImageSource.gallery);

    if (seleccion != null) {
      setState(() {
        _imagen = File(seleccion.path);
      });
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo superior
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.asset(
              'assets/fondo_login.png',
              fit: BoxFit.cover,
            ),
          ),

          // Botones superiores (volver y menú)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Icon(Icons.menu, color: Colors.white),
                ],
              ),
            ),
          ),

          // Contenido blanco redondeado
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _seleccionarImagen,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:
                            _imagen != null ? FileImage(_imagen!) : null,
                        child: _imagen == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Información personal
                  const Text("Información personal",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  // Campo nombre
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _nombreController,
                      decoration: const InputDecoration(
                        labelText: "Nombre completo",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Campo correo
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _correoController,
                      decoration: const InputDecoration(
                        labelText: "Correo electrónico",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sección seguridad
                  const Text("Seguridad y contraseña",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ListTile(
                    tileColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    leading: const Icon(Icons.lock_outline),
                    title: const Text("Cambiar contraseña"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // lógica futura
                    },
                  ),
                  const SizedBox(height: 20),

                  // Botón cerrar sesión
                  TextButton.icon(
                    onPressed: () {
                      // cerrar sesión lógica futura
                    },
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: const Text("Cerrar sesión",
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
