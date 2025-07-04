import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../models/product.dart';

class OrderProvider with ChangeNotifier {
  Order? _currentOrder;
  final List<Order> _orders = [];

  // Getters
  Order? get currentOrder => _currentOrder;
  List<Order> get orders => _orders;
  
  // Statistics getters
  double get totalSales => _orders.fold(0.0, (sum, order) => sum + order.total);
  int get totalOrders => _orders.length;
  double get averageOrderValue => totalOrders > 0 ? totalSales / totalOrders : 0.0;

  // Add a product to the current order
  void addToOrder(Product product) {
    if (_currentOrder == null) {
      _currentOrder = Order(
        items: [],
        timestamp: DateTime.now(),
      );
    }

    _currentOrder!.addItem(product);
    notifyListeners();
  }

  // Remove a product from the current order
  void removeFromOrder(Product product) {
    if (_currentOrder != null) {
      _currentOrder!.removeItem(product);
      notifyListeners();
    }
  }

  // Update quantity of a product in the current order
  void updateQuantity(Product product, int quantity) {
    if (_currentOrder != null) {
      _currentOrder!.updateItemQuantity(product, quantity);
      notifyListeners();
    }
  }

  // Complete the current order
  void completeOrder() {
    if (_currentOrder != null && _currentOrder!.items.isNotEmpty) {
      _currentOrder!.status = OrderStatus.completed;
      _orders.add(_currentOrder!);
      _currentOrder = null;
      notifyListeners();
    }
  }

  // Cancel the current order
  void cancelOrder() {
    if (_currentOrder != null) {
      _currentOrder!.status = OrderStatus.cancelled;
      _currentOrder = null;
      notifyListeners();
    }
  }

  // Get orders for a specific date range
  List<Order> getOrdersInRange(DateTime start, DateTime end) {
    return _orders.where((order) {
      return order.timestamp.isAfter(start) && 
             order.timestamp.isBefore(end);
    }).toList();
  }

  // Get total sales for a specific date range
  double getSalesInRange(DateTime start, DateTime end) {
    return getOrdersInRange(start, end)
        .fold(0.0, (sum, order) => sum + order.total);
  }

  // Get the number of orders for a specific date range
  int getOrderCountInRange(DateTime start, DateTime end) {
    return getOrdersInRange(start, end).length;
  }

  // Clear all orders (useful for testing or resetting)
  void clearOrders() {
    _orders.clear();
    _currentOrder = null;
    notifyListeners();
  }
}
