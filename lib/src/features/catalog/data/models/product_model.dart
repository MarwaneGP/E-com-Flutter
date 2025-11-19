import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.thumbnail,
    required super.images,
    required super.description,
    required super.category,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
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
  }}

