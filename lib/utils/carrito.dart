import '../models/producto.dart';

class Carrito {
  static final List<Producto> _items = [];

  static void agregar(Producto producto) {
    final index = _items.indexWhere((item) => item.nombre == producto.nombre);
    if (index >= 0) {
      _items[index].cantidad++;
    } else {
      _items.add(producto..cantidad = 1);
    }
  }

  static void quitarUnidad(Producto producto) {
    final index = _items.indexWhere((item) => item.nombre == producto.nombre);
    if (index >= 0) {
      if (_items[index].cantidad > 1) {
        _items[index].cantidad--;
      } else {
        _items.removeAt(index);
      }
    }
  }

  static List<Producto> obtenerTodos() {
    return _items;
  }

  static void limpiar() {
    _items.clear();
  }

  static double total() {
    return _items.fold(0.0, (sum, item) {
      final precio = double.tryParse(item.precio.replaceAll('\$', '')) ?? 0.0;
      return sum + (precio * item.cantidad);
    });
  }

  static void eliminar(Producto producto) {
    _items.removeWhere((item) => item.nombre == producto.nombre);
  }
}
