library my_app.globals;

/// ID del usuario que inició sesión
int? usuarioGlobalId;

/// ID numérico del rol (1 = admin, 2 = staff, 3 = cliente, etc.)
int? usuarioGlobalRoleId;

/// Nombre o tipo del rol (opcional, si lo quieres usar como texto)
String get usuarioGlobalRol {
  switch (usuarioGlobalRoleId) {
    case 1:
      return 'admin';
    case 2:
      return 'staff';
    case 3:
      return 'cliente';
    default:
      return 'desconocido';
  }
}

/// Nombre completo del usuario
String? usuarioGlobalNombre;

/// Correo electrónico del usuario
String? usuarioGlobalCorreo;

String? usuarioGlobalFoto;

