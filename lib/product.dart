class Product {
  final int id;
  final String name;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1, // Default quantity is 1
  });
}
