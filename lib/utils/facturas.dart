import '../models/producto.dart';

class Facturas {
  static final List<List<Producto>> _facturas = [];

  static void agregarFactura(List<Producto> productos) {
    _facturas.add(List.from(productos)); // Guardar copia
  }

  static List<List<Producto>> obtenerFacturas() {
    return _facturas;
  }
}
