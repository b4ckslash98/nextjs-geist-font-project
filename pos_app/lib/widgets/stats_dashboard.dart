import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';

class StatsDashboard extends StatelessWidget {
  const StatsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overall Statistics',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildStatCards(context),
            const SizedBox(height: 24),
            const Text(
              'Sales Chart',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildSalesChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final orders = orderProvider.orders;

    final totalSales = orders.fold(0.0, (sum, order) => sum + order.total);
    final totalOrders = orders.length;
    final averageOrderValue = totalOrders > 0 ? totalSales / totalOrders : 0.0;

    return Row(
      children: [
        _StatCard(
          title: 'Total Sales',
          value: '\$${totalSales.toStringAsFixed(2)}',
          icon: Icons.attach_money,
        ),
        const SizedBox(width: 16),
        _StatCard(
          title: 'Orders',
          value: totalOrders.toString(),
          icon: Icons.shopping_cart,
        ),
        const SizedBox(width: 16),
        _StatCard(
          title: 'Avg Order',
          value: '\$${averageOrderValue.toStringAsFixed(2)}',
          icon: Icons.analytics,
        ),
      ],
    );
  }

  Widget _buildSalesChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 3),
              const FlSpot(2.6, 2),
              const FlSpot(4.9, 5),
              const FlSpot(6.8, 3.1),
              const FlSpot(8, 4),
              const FlSpot(9.5, 3),
              const FlSpot(11, 4),
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: true),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
