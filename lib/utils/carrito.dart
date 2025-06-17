import '../models/producto.dart';

class Carrito {
  static final List<Producto> _items = [];

  static void agregar(Producto producto) {
    _items.add(producto);
  }

  static List<Producto> obtenerProductos() {
    return _items;
  }

  static void eliminar(Producto producto) {
    _items.remove(producto);
  }

  static void limpiar() {
    _items.clear();
  }
}
