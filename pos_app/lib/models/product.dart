class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.description = '',
  });

  // Sample products data
  static List<Product> get sampleProducts => [
    Product(
      id: '1',
      name: 'Quarter Pounder with Cheese',
      price: 5.99,
      imageUrl: 'assets/images/burger1.png',
      description: 'Classic quarter pound beef patty with cheese',
    ),
    Product(
      id: '2',
      name: 'Big Mac',
      price: 6.49,
      imageUrl: 'assets/images/burger2.png',
      description: 'Two all-beef patties, special sauce, lettuce, cheese',
    ),
    Product(
      id: '3',
      name: 'Double Quarter Pounder',
      price: 7.49,
      imageUrl: 'assets/images/burger3.png',
      description: 'Two quarter pound beef patties with cheese',
    ),
    Product(
      id: '4',
      name: 'Premium Chicken Sandwich',
      price: 5.99,
      imageUrl: 'assets/images/burger4.png',
      description: 'Crispy chicken fillet with lettuce and mayo',
    ),
  ];
}
