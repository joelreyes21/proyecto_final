import 'package:proyecto_final/models/producto.dart';

class Factura {
  final int id;
  final DateTime fecha;
  final double total;
  final List<Producto> productos;

  Factura({
    required this.id,
    required this.fecha,
    required this.total,
    required this.productos,
  });

  factory Factura.fromJson(Map<String, dynamic> json) {
    return Factura(
      id: json['id'],
      fecha: DateTime.parse(json['fecha']),
      total: double.parse(json['total'].toString()),
      productos: [], // aún no se cargan productos
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'total': total,
    };
  }
}
