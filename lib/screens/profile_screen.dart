import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/globals.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  File? _imagenPerfil;

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagenPerfil = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo_login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _seleccionarImagen,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.deepPurple,
                            backgroundImage: _imagenPerfil != null ? FileImage(_imagenPerfil!) : null,
                            child: _imagenPerfil == null
                                ? const Icon(Icons.person, size: 40, color: Colors.white)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Información personal',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: usuarioGlobalNombre ?? 'Nombre completo',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: usuarioGlobalCorreo ?? 'Correo electrónico',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Seguridad y contraseña',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          leading: const Icon(Icons.lock_outline),
                          title: const Text("Cambiar contraseña"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.logout, color: Colors.red),
                          label: const Text("Cerrar sesión", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
