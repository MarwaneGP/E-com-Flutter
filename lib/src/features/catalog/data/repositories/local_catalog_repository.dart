import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../models/product_model.dart';

class LocalCatalogRepository implements CatalogRepository {
  LocalCatalogRepository();

  final List<Product> _products =
      _mockProducts.map((data) => ProductModel.fromMap(data)).toList();

  @override
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 350));
    return _products;
  }

  @override
  Future<Product> fetchProduct(String id) async {
    await Future.delayed(const Duration(milliseconds: 250));
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (_) {
      throw Exception('Produit introuvable');
    }
  }
}

const List<Map<String, dynamic>> _mockProducts = [
  {
    "id": "1",
    "title": "Sneakers Velocity",
    "price": 129.99,
    "thumbnail":
        "https://images.unsplash.com/photo-1511467687858-23d96c32e4ae?auto=format&fit=crop&w=800&q=60",
    "images": [
      "https://images.unsplash.com/photo-1511467687858-23d96c32e4ae?auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1519744792095-2f2205e87b6f?auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800&q=60",
    ],
    "description":
        "Chaussures de running legeres avec mousse reactive pour vos entrainements quotidiens.",
    "category": "shoes",
  },
  {
    "id": "2",
    "title": "Montre Aurora",
    "price": 249.00,
    "thumbnail":
        "https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=800&q=60",
    "images": [
      "https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1518544889280-37f4ca38e4b4?auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?auto=format&fit=crop&w=800&q=60",
    ],
    "description":
        "Montre connectee avec suivi cardio, NFC et autonomie de 5 jours.",
    "category": "accessories",
  },
  {
    "id": "3",
    "title": "Casque Pulse ANC",
    "price": 179.50,
    "thumbnail":
        "https://images.unsplash.com/photo-1511367466-95bf97d16a5e?auto=format&fit=crop&w=800&q=60",
    "images": [
      "https://images.unsplash.com/photo-1511367466-95bf97d16a5e?auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1484704849700-f032a568e944?auto=format&fit=crop&w=800&q=60",
    ],
    "description":
        "Casque Bluetooth circum-aural avec reduction de bruit active et 30h d'autonomie.",
    "category": "audio",
  },
  {
    "id": "4",
    "title": "Sac Explorer 24L",
    "price": 89.90,
    "thumbnail":
        "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=800&q=60",
    "images": [
      "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=800&q=60",
    ],
    "description":
        "Sac a dos etanche avec compartiment laptop et poches modulaires.",
    "category": "bags",
  },
  {
    "id": "5",
    "title": "Lampe Halo Desk",
    "price": 59.99,
    "thumbnail":
        "https://images.unsplash.com/photo-1481277542470-605612bd2d61?auto=format&fit=crop&w=800&q=60",
    "images": [
      "https://images.unsplash.com/photo-1481277542470-605612bd2d61?auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1481988535861-271139e06469?auto=format&fit=crop&w=800&q=60",
    ],
    "description":
        "Lampe de bureau minimaliste avec intensite reglable et recharge sans fil.",
    "category": "home",
  },
  {
    "id": "6",
    "title": "Tasse Neo Ceramic",
    "price": 24.90,
    "thumbnail":
        "https://images.unsplash.com/photo-1470337458703-46ad1756a187?auto=format&fit=crop&w=800&q=60",
    "images": [
      "https://images.unsplash.com/photo-1470337458703-46ad1756a187?auto=format&fit=crop&w=800&q=60",
    ],
    "description":
        "Tasse en ceramique double paroi, ideale pour garder vos boissons au chaud.",
    "category": "kitchen",
  },
];

