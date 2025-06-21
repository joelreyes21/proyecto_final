class Producto {
  final int id;
  final String nombre;
  final String precio;
  final String imagen;
  int cantidad; // ← Ya no es final
  final String descripcion;

  Producto({
    this.id = 0,
    required this.nombre,
    required this.precio,
    required this.imagen,
    this.cantidad = 1,
    this.descripcion = '',
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'] ?? 0,
      nombre: json['nombre'],
      precio: json['precio'],
      imagen: json['imagen'] ?? '',
      cantidad: json['cantidad'] ?? 1,
      descripcion: json['descripcion'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'imagen': imagen,
      'cantidad': cantidad,
      'descripcion': descripcion,
    };
  }
}
