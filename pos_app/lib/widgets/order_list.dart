import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Current Order',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildCompleteOrderButton(context),
              ],
            ),
            const SizedBox(height: 16),
            _buildOrderItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCompleteOrderButton(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final hasItems = orderProvider.currentOrder?.items.isNotEmpty ?? false;

    return ElevatedButton.icon(
      onPressed: hasItems
          ? () {
              orderProvider.completeOrder();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order completed successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          : null,
      icon: const Icon(Icons.check),
      label: const Text('Complete Order'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildOrderItems(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        final currentOrder = orderProvider.currentOrder;
        final items = currentOrder?.items ?? [];

        if (items.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'No items in current order',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item.product.name),
                    subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (item.quantity > 1) {
                              currentOrder?.updateItemQuantity(
                                item.product,
                                item.quantity - 1,
                              );
                            } else {
                              currentOrder?.removeItem(item.product);
                            }
                            orderProvider.notifyListeners();
                          },
                        ),
                        Text(
                          item.quantity.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            currentOrder?.updateItemQuantity(
                              item.product,
                              item.quantity + 1,
                            );
                            orderProvider.notifyListeners();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${currentOrder?.total.toStringAsFixed(2) ?? '0.00'}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
