import 'package:flutter/material.dart';
import '../widgets/stats_dashboard.dart';
import '../widgets/order_list.dart';
import '../widgets/product_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the device is a tablet based on width
    final isTablet = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      appBar: AppBar(
        title: const Text('POS System'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement settings
            },
          ),
        ],
      ),
      body: SafeArea(
        child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        // Left sidebar with statistics (only on tablet)
        const SizedBox(
          width: 300,
          child: StatsDashboard(),
        ),
        // Main content area
        Expanded(
          child: Column(
            children: [
              // Order list takes up 40% of the height
              const SizedBox(
                height: 300,
                child: OrderList(),
              ),
              // Product grid takes up remaining space
              const Expanded(
                child: ProductGrid(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneLayout() {
    return Column(
      children: [
        // Order list takes up 40% of the height
        const SizedBox(
          height: 300,
          child: OrderList(),
        ),
        // Product grid takes up remaining space
        const Expanded(
          child: ProductGrid(),
        ),
        // Bottom navigation for phone layout
        BottomNavigationBar(
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            // TODO: Implement navigation
          },
        ),
      ],
    );
  }
}
