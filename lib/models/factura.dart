import 'producto.dart';

class Factura {
  final DateTime fecha;
  final List<Producto> productos;
  final double total;

  Factura({required this.fecha, required this.productos, required this.total});
}
