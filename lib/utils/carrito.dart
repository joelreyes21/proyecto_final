import '../models/producto.dart';

class Carrito {
  static final List<Producto> _items = [];

  static void agregar(Producto producto) {
    _items.add(producto);
  }

  static List<Producto> obtenerTodos() {
    return _items;
  }

  static void limpiar() {
    _items.clear();
  }

  static double total() {
    return _items.fold(0.0, (sum, item) => sum + double.parse(item.precio.replaceAll('\$', '')));
  }
  static void eliminar(Producto producto) {
  _items.remove(producto);
}

}
