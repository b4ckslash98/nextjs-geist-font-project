# Point of Sales (POS) Application

A modern, responsive Point of Sales application built with Flutter for iPad and iPhone. This application provides a clean interface for managing orders, tracking sales, and viewing statistics.

## Features

- 📱 Responsive design that adapts to both iPad and iPhone
- 💳 Easy-to-use order management system
- 📊 Real-time sales statistics and charts
- 🍔 Product catalog with images
- 💰 Order tracking and history
- 📈 Sales analytics dashboard

## Screenshots

The application features a modern, dark-themed interface with:
- Statistics dashboard (tablet view)
- Product grid with menu items
- Current order management
- Sales history and analytics

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- iOS Simulator or Android Emulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/pos_app.git
```

2. Navigate to the project directory:
```bash
cd pos_app
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the application:
```bash
flutter run
```

## Project Structure

```
lib/
├── models/
│   ├── order.dart
│   └── product.dart
├── providers/
│   └── order_provider.dart
├── screens/
│   └── home_screen.dart
├── widgets/
│   ├── stats_dashboard.dart
│   ├── product_grid.dart
│   └── order_list.dart
└── main.dart
```

## State Management

The application uses Provider for state management. The main state is managed through:
- `OrderProvider`: Manages orders, current order state, and provides statistics

## Responsive Design

The application provides different layouts for:
- Tablet (iPad): Full layout with side statistics panel
- Phone (iPhone): Compact layout with bottom navigation

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
