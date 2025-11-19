class Product {
  final String id;
  final String title;
  final double price;
  final String thumbnail;
  final List<String> images;
  final String description;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.images,
    required this.description,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'].toString(),
      title: map['title'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0,
      thumbnail: map['thumbnail'] ?? '',
      images: (map['images'] as List<dynamic>? ?? [])
          .map((img) => img.toString())
          .toList(),
      description: map['description'] ?? '',
      category: map['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
      'images': images,
      'description': description,
      'category': category,
    };
  }
}
