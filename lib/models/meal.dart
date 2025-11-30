class Meal {
  final String id; // Unique identifier for the meal
  final String name;
  final String imageUrl;
  final double price;
  final String category; // breakfast, lunch, tea, supper
  final bool isAvailable; // To track if meal is available
  final String description; // Optional description of the meal
  bool isSelected;
  int quantity;

  Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    this.isAvailable = true,
    this.description = '',
    this.isSelected = false,
    this.quantity = 0,
  });

  double get totalPrice => price * quantity;

  // For converting from JSON (from backend)
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      category: json['category'] ?? '',
      isAvailable: json['isAvailable'] ?? true,
      description: json['description'] ?? '',
    );
  }

  // For converting to JSON (to backend)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'category': category,
      'isAvailable': isAvailable,
      'description': description,
      'quantity': quantity,
      'isSelected': isSelected,
    };
  }

  // Create a copy of the meal with modified properties
  Meal copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? price,
    String? category,
    bool? isAvailable,
    String? description,
    bool? isSelected,
    int? quantity,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description ?? this.description,
      isSelected: isSelected ?? this.isSelected,
      quantity: quantity ?? this.quantity,
    );
  }
}
