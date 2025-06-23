import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GestionUsuariosScreen extends StatefulWidget {
  const GestionUsuariosScreen({super.key});

  @override
  State<GestionUsuariosScreen> createState() => _GestionUsuariosScreenState();
}

class _GestionUsuariosScreenState extends State<GestionUsuariosScreen> {
  List<dynamic> usuarios = [];
  bool isLoading = true;

  final Map<int, String> roles = {
    1: 'admin',
    2: 'staff',
    3: 'cliente',
  };

  @override
  void initState() {
    super.initState();
    fetchUsuarios();
  }

  Future<void> fetchUsuarios() async {
    try {
final response = await http.get(Uri.parse('http://192.168.0.8:3000/api/auth/users'));
      if (response.statusCode == 200) {
        setState(() {
          usuarios = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error al obtener usuarios: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> eliminarUsuario(int id) async {
  try {
    final response = await http.delete(Uri.parse('http://192.168.0.8:3000/api/auth/deleteUser/$id'));
    if (response.statusCode == 200) {
      setState(() {
        usuarios.removeWhere((user) => user['id'] == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Usuario eliminado")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No se pudo eliminar")));
    }
  } catch (e) {
    print("Error al eliminar usuario: $e");
  }
}


  Future<void> cambiarRol(int userId, int nuevoRol) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.0.8:3000/api/auth/updateRole/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"roleId": nuevoRol}),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Rol actualizado")));
      }
    } catch (e) {
      print("Error al cambiar rol: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Usuarios"),
        backgroundColor: const Color.fromARGB(255, 4, 3, 3),
        foregroundColor: Colors.white,

      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : usuarios.isEmpty
              ? const Center(child: Text("No hay usuarios registrados"))
              : ListView.builder(
                  itemCount: usuarios.length,
                  itemBuilder: (context, index) {
                    final user = usuarios[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('${user['firstName']} ${user['lastName']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email: ${user['email']}'),
                            Row(
                              children: [
                                const Text("Rol: "),
                                DropdownButton<int>(
                                  value: user['roleId'],
                                  items: roles.entries
                                      .map((entry) => DropdownMenuItem<int>(
                                            value: entry.key,
                                            child: Text(entry.value),
                                          ))
                                      .toList(),
                                  onChanged: (nuevoRol) {
                                    if (nuevoRol != null) {
                                      setState(() => user['roleId'] = nuevoRol);
                                      cambiarRol(user['id'], nuevoRol);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => eliminarUsuario(user['id']),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
