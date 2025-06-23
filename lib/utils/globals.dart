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

/// Lista global de productos para mostrar en el Home
List<Map<String, dynamic>> productosGlobales = [
  {
    'nombre': 'Expresso macchiato',
    'precio': '\$3.70',
    'imagen': 'assets/espresso.png',
    'descripcion': 'Un espresso fuerte con un toque de leche espumada.',
    'categoria': 'Hot Drinks',
  },
  {
    'nombre': 'Té chai',
    'precio': '\$6.20',
    'imagen': 'assets/te.png',
    'descripcion': 'Té con especias y leche, ideal para tardes frías.',
    'categoria': 'Hot Drinks',
  },
  {
    'nombre': 'Granita de café',
    'precio': '\$4.50',
    'imagen': 'assets/granita.png',
    'descripcion': 'Café helado con textura granulada, refrescante.',
    'categoria': 'Cold Drinks',
  },
  {
    'nombre': 'Tiramisu',
    'precio': '\$4.50',
    'imagen': 'assets/tiramisu.png',
    'descripcion': 'Postre italiano con café y mascarpone.',
    'categoria': 'Pastries',
  },
  {
    'nombre': 'Sandwich',
    'precio': '\$4.50',
    'imagen': 'assets/sandwich.png',
    'descripcion': 'Sándwich clásico con ingredientes frescos.',
    'categoria': 'Sandwiches',
  },
  {
    'nombre': 'Sandwich de queso',
    'precio': '\$4.50',
    'imagen': 'assets/sandwich_cheese.png',
    'descripcion': 'Sándwich relleno de queso derretido.',
    'categoria': 'Sandwiches',
  },
  {
    'nombre': 'Chocolate lasagna',
    'precio': '\$4.50',
    'imagen': 'assets/chocolate_lasagna.png',
    'descripcion': 'Postre de chocolate en capas tipo lasagna.',
    'categoria': 'Pastries',
  },
  {
    'nombre': 'Strawberry shortcake',
    'precio': '\$4.50',
    'imagen': 'assets/strawberryshortcake.png',
    'descripcion': 'Pastel suave con crema y fresas frescas.',
    'categoria': 'Pastries',
  },
];
