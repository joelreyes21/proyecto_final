import '../models/factura.dart';
import '../models/producto.dart';

class Facturas {
  static final List<Factura> _lista = [];

  static void agregar(Factura f) => _lista.add(f);
  static List<Factura> obtenerTodas() => List.unmodifiable(_lista);
}
