// lib/screens/favorites_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<Map<String, dynamic>> _favoriteProducts = [
    {
      'id': '1',
      'name': 'iPhone 15 Pro',
      'brand': 'Apple',
      'price': '\$1,199',
      'originalPrice': '\$1,399',
      'discount': '15%',
      'rating': 4.8,
      'reviews': 234,
      'image': 'iphone15',
      'category': 'Smartphones',
      'inStock': true,
      'addedDate': '2024-01-15',
      'color': 'Titanio Negro',
      'storage': '256GB',
    },
    {
      'id': '2',
      'name': 'Sony WH-1000XM5',
      'brand': 'Sony',
      'price': '\$399',
      'originalPrice': '\$449',
      'discount': '12%',
      'rating': 4.7,
      'reviews': 456,
      'image': 'sony_headphones',
      'category': 'Audio',
      'inStock': true,
      'addedDate': '2024-01-10',
      'color': 'Negro',
      'features': 'Cancelación de ruido',
    },
    {
      'id': '3',
      'name': 'MacBook Pro M3',
      'brand': 'Apple',
      'price': '\$2,499',
      'originalPrice': '\$2,799',
      'discount': '11%',
      'rating': 4.9,
      'reviews': 189,
      'image': 'macbook',
      'category': 'Laptops',
      'inStock': false,
      'addedDate': '2024-01-05',
      'color': 'Plata',
      'storage': '512GB',
      'ram': '16GB',
    },
    {
      'id': '4',
      'name': 'PlayStation 5',
      'brand': 'Sony',
      'price': '\$499',
      'originalPrice': '\$549',
      'discount': '9%',
      'rating': 4.8,
      'reviews': 567,
      'image': 'ps5',
      'category': 'Gaming',
      'inStock': true,
      'addedDate': '2024-01-02',
      'edition': 'Standard',
      'includes': 'Control DualSense',
    },
    {
      'id': '5',
      'name': 'Samsung Galaxy S24',
      'brand': 'Samsung',
      'price': '\$999',
      'rating': 4.6,
      'reviews': 123,
      'image': 'samsung_s24',
      'category': 'Smartphones',
      'inStock': true,
      'addedDate': '2024-01-20',
      'color': 'Violeta',
      'storage': '128GB',
    },
    {
      'id': '6',
      'name': 'Apple Watch Series 9',
      'brand': 'Apple',
      'price': '\$429',
      'rating': 4.5,
      'reviews': 345,
      'image': 'apple_watch',
      'category': 'Wearables',
      'inStock': true,
      'addedDate': '2024-01-18',
      'size': '45mm',
      'band': 'Deportiva',
    },
  ];

  bool _showOnlyInStock = false;
  String _sortBy = 'recent';
  // ignore: unused_field
  final List<String> _sortOptions = [
    'recent',
    'price_low',
    'price_high',
    'rating',
    'name',
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.pink;

    final filteredProducts = _showOnlyInStock
        ? _favoriteProducts.where((p) => p['inStock']).toList()
        : _favoriteProducts;

    filteredProducts.sort((a, b) {
      switch (_sortBy) {
        case 'recent':
          return b['addedDate'].compareTo(a['addedDate']);
        case 'price_low':
          final priceA = double.parse(
            a['price'].replaceAll('\$', '').replaceAll(',', ''),
          );
          final priceB = double.parse(
            b['price'].replaceAll('\$', '').replaceAll(',', ''),
          );
          return priceA.compareTo(priceB);
        case 'price_high':
          final priceA = double.parse(
            a['price'].replaceAll('\$', '').replaceAll(',', ''),
          );
          final priceB = double.parse(
            b['price'].replaceAll('\$', '').replaceAll(',', ''),
          );
          return priceB.compareTo(priceA);
        case 'rating':
          return b['rating'].compareTo(a['rating']);
        case 'name':
          return a['name'].compareTo(b['name']);
        default:
          return 0;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Favoritos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _showClearAllDialog,
            color: primaryColor,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros y ordenamiento
          _buildFiltersSection(isDarkMode, primaryColor),

          // Contador de productos
          _buildCounterSection(filteredProducts.length),

          // Lista de favoritos
          if (filteredProducts.isEmpty)
            _buildEmptyState(primaryColor, isDarkMode)
          else
            Expanded(
              child: _buildFavoritesList(
                filteredProducts,
                isDarkMode,
                primaryColor,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _shareFavoritesList,
        backgroundColor: primaryColor,
        icon: const Icon(Icons.share),
        label: const Text('Compartir'),
      ),
    );
  }

  Widget _buildFiltersSection(bool isDarkMode, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Filtro de disponibilidad
          Expanded(
            child: FilterChip(
              label: Text('Solo disponibles'),
              selected: _showOnlyInStock,
              selectedColor: primaryColor.withOpacity(0.2),
              checkmarkColor: primaryColor,
              labelStyle: TextStyle(
                color: _showOnlyInStock ? primaryColor : Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              onSelected: (selected) {
                setState(() {
                  _showOnlyInStock = selected;
                });
              },
            ),
          ),

          const SizedBox(width: 10),

          // Ordenamiento
          PopupMenuButton<String>(
            icon: Row(
              children: [
                const Icon(Icons.sort, size: 20),
                const SizedBox(width: 5),
                Text(
                  _getSortLabel(_sortBy),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            onSelected: (value) {
              setState(() {
                _sortBy = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'recent',
                child: Text('Más recientes'),
              ),
              const PopupMenuItem(
                value: 'price_low',
                child: Text('Precio: menor a mayor'),
              ),
              const PopupMenuItem(
                value: 'price_high',
                child: Text('Precio: mayor a menor'),
              ),
              const PopupMenuItem(
                value: 'rating',
                child: Text('Mejor valorados'),
              ),
              const PopupMenuItem(value: 'name', child: Text('Nombre A-Z')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounterSection(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count ${count == 1 ? 'producto' : 'productos'} favoritos',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.pink,
            ),
          ),
          if (count > 0)
            TextButton.icon(
              onPressed: _addAllToCart,
              icon: const Icon(Icons.shopping_cart_checkout, size: 18),
              label: const Text('+ Carrito'),
              style: TextButton.styleFrom(foregroundColor: Colors.green),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(Color primaryColor, bool isDarkMode) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.favorite_border, size: 80, color: primaryColor),
            ),
            const SizedBox(height: 30),
            Text(
              'Tu lista de favoritos está vacía',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Guarda tus productos electrónicos favoritos '
                'para acceder a ellos rápidamente y recibir notificaciones '
                'de descuentos y disponibilidad.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _browseProducts,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              icon: const Icon(Icons.explore),
              label: const Text(
                'Explorar Productos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList(
    List<Map<String, dynamic>> products,
    bool isDarkMode,
    Color primaryColor,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildFavoriteItem(product, isDarkMode, primaryColor);
      },
    );
  }

  Widget _buildFavoriteItem(
    Map<String, dynamic> product,
    bool isDarkMode,
    Color primaryColor,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contenido superior (imagen + info)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto (ancho fijo)
              Container(
                width: 100, // Reducido para dar más espacio
                height: 120, // Reducido para mantener proporción
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  color: Colors.grey[100],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      child: Image.asset(
                        'assets/products/${product['image']}.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.devices,
                              size: 40, // Reducido
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    ),
                    if (product['discount'] != null)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            product['discount'],
                            style: const TextStyle(
                              fontSize: 10, // Reducido
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    if (!product['inStock'])
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'AGOTADO',
                              style: TextStyle(
                                fontSize: 12, // Reducido
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Información del producto
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10), // Padding reducido
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Encabezado
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  product['brand'],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                product['addedDate'],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product['name'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),

                      // Especificaciones
                      if (product['color'] != null ||
                          product['storage'] != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Wrap(
                            spacing: 4,
                            runSpacing: 2,
                            children: [
                              if (product['color'] != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    product['color'],
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              if (product['storage'] != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    product['storage'],
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              if (product['ram'] != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    product['ram'],
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                        ),

                      // Precio y rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['price'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (product['originalPrice'] != null)
                                Text(
                                  product['originalPrice'],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[500],
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, size: 12, color: Colors.amber),
                              const SizedBox(width: 2),
                              Text(
                                '${product['rating']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Botones de acción - CORREGIDO
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 36, // Altura fija
                    child: OutlinedButton.icon(
                      onPressed: () => _removeFromFavorites(product['id']),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      icon: const Icon(Icons.delete_outline, size: 16),
                      label: const Text(
                        'Eliminar',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 36, // Altura fija
                    child: ElevatedButton.icon(
                      onPressed: product['inStock']
                          ? () => _addToCart(product['id'])
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.shopping_cart, size: 16),
                      label: Text(
                        product['inStock'] ? 'Carrito' : 'Agotado',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Métodos de utilidad
  String _getSortLabel(String sortBy) {
    switch (sortBy) {
      case 'recent':
        return 'Recientes';
      case 'price_low':
        return 'Precio ↑';
      case 'price_high':
        return 'Precio ↓';
      case 'rating':
        return 'Rating';
      case 'name':
        return 'Nombre';
      default:
        return 'Ordenar';
    }
  }

  // Métodos de la lógica
  void _removeFromFavorites(String productId) {
    setState(() {
      _favoriteProducts.removeWhere((product) => product['id'] == productId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Producto eliminado de favoritos'),
        backgroundColor: Colors.pink,
        action: SnackBarAction(
          label: 'Deshacer',
          textColor: Colors.white,
          onPressed: () {
            // Aquí iría la lógica para restaurar el producto
            setState(() {});
          },
        ),
      ),
    );
  }

  void _addToCart(String productId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Producto añadido al carrito'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addAllToCart() {
    final availableProducts = _favoriteProducts.where((p) => p['inStock']);
    if (availableProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay productos disponibles para añadir'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Añadir todos al carrito'),
          content: Text(
            '¿Deseas añadir ${availableProducts.length} productos disponibles al carrito?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${availableProducts.length} productos añadidos al carrito',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              child: const Text('Añadir'),
            ),
          ],
        );
      },
    );
  }

  void _showClearAllDialog() {
    if (_favoriteProducts.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Vaciar lista de favoritos'),
          content: const Text(
            '¿Estás seguro de que deseas eliminar todos los productos de tu lista de favoritos?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _favoriteProducts.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Lista de favoritos vaciada'),
                    backgroundColor: Colors.pink,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Vaciar lista'),
            ),
          ],
        );
      },
    );
  }

  void _shareFavoritesList() {
    if (_favoriteProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay productos para compartir'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Compartir lista de favoritos'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Compartir vía:'),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.email, size: 40, color: Colors.blue),
                  Icon(Icons.message, size: 40, color: Colors.green),
                  Icon(Icons.link, size: 40, color: Colors.purple),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _browseProducts() {
    // Navegar a la pantalla de exploración
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navegando a productos'),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
