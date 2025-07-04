import 'product.dart';

class OrderItem {
  final Product product;
  int quantity;
  final double price;

  OrderItem({
    required this.product,
    this.quantity = 1,
    required this.price,
  });

  double get total => price * quantity;
}

class Order {
  final String id;
  final List<OrderItem> items;
  final DateTime timestamp;
  OrderStatus status;

  Order({
    required this.items,
    required this.timestamp,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString(),
       status = OrderStatus.pending;

  double get total => items.fold(0, (sum, item) => sum + item.total);

  void addItem(Product product) {
    final existingItem = items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => OrderItem(
        product: product,
        price: product.price,
        quantity: 0,
      ),
    );

    if (existingItem.quantity == 0) {
      items.add(existingItem);
    }
    existingItem.quantity++;
  }

  void removeItem(Product product) {
    items.removeWhere((item) => item.product.id == product.id);
  }

  void updateItemQuantity(Product product, int quantity) {
    final item = items.firstWhere((item) => item.product.id == product.id);
    if (quantity <= 0) {
      removeItem(product);
    } else {
      item.quantity = quantity;
    }
  }
}

enum OrderStatus {
  pending,
  processing,
  completed,
  cancelled
}
