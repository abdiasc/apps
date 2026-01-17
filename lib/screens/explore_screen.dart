// lib/screens/explore_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<String> _categories = [
    'Todos',
    'Smartphones',
    'Laptops',
    'Tablets',
    'Audio',
    'Wearables',
    'Gaming',
    'Accesorios',
    'Smart Home',
    'Cámaras',
  ];

  final List<Map<String, dynamic>> _featuredProducts = [
    {
      'name': 'iPhone 15 Pro',
      'category': 'Smartphones',
      'price': '\$1,199',
      'originalPrice': '\$1,399',
      'discount': '15%',
      'rating': 4.8,
      'reviews': 234,
      'image': 'iphone15',
      'isFavorite': true,
    },
    {
      'name': 'MacBook Pro M3',
      'category': 'Laptops',
      'price': '\$2,499',
      'originalPrice': '\$2,799',
      'discount': '11%',
      'rating': 4.9,
      'reviews': 189,
      'image': 'macbook',
      'isFavorite': false,
    },
    {
      'name': 'Sony WH-1000XM5',
      'category': 'Audio',
      'price': '\$399',
      'originalPrice': '\$449',
      'discount': '12%',
      'rating': 4.7,
      'reviews': 456,
      'image': 'sony_headphones',
      'isFavorite': true,
    },
    {
      'name': 'PlayStation 5',
      'category': 'Gaming',
      'price': '\$499',
      'originalPrice': '\$549',
      'discount': '9%',
      'rating': 4.8,
      'reviews': 567,
      'image': 'ps5',
      'isFavorite': false,
    },
  ];

  final List<Map<String, dynamic>> _newArrivals = [
    {
      'name': 'Samsung Galaxy S24',
      'category': 'Smartphones',
      'price': '\$999',
      'isNew': true,
      'image': 'samsung_s24',
    },
    {
      'name': 'iPad Pro M2',
      'category': 'Tablets',
      'price': '\$1,099',
      'isNew': true,
      'image': 'ipad_pro',
    },
    {
      'name': 'Apple Watch Series 9',
      'category': 'Wearables',
      'price': '\$429',
      'isNew': true,
      'image': 'apple_watch',
    },
    {
      'name': 'DJI Mini 4 Pro',
      'category': 'Cámaras',
      'price': '\$759',
      'isNew': true,
      'image': 'dji_drone',
    },
  ];

  final List<Map<String, dynamic>> _brands = [
    {'name': 'Apple', 'logo': 'apple', 'products': 45},
    {'name': 'Samsung', 'logo': 'samsung', 'products': 38},
    {'name': 'Sony', 'logo': 'sony', 'products': 29},
    {'name': 'LG', 'logo': 'lg', 'products': 22},
    {'name': 'Dell', 'logo': 'dell', 'products': 31},
    {'name': 'HP', 'logo': 'hp', 'products': 27},
  ];

  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar Productos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de búsqueda
            _buildSearchBar(isDarkMode, primaryColor),

            // Categorías
            _buildCategoriesSection(),

            // Productos destacados
            _buildFeaturedProducts(isDarkMode, primaryColor),

            // Nuevos lanzamientos
            _buildNewArrivals(isDarkMode),

            // Marcas populares
            _buildPopularBrands(isDarkMode),

            // Ofertas especiales
            _buildSpecialOffers(isDarkMode, primaryColor),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(bool isDarkMode, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Qué estás buscando?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Encuentra los mejores productos electrónicos',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar productos, marcas, categorías...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      prefixIcon: Icon(Icons.search, color: primaryColor),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    onPressed: _showFilters,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategoryIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(_categories[index]),
              selected: isSelected,
              selectedColor: Colors.green,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              onSelected: (selected) {
                setState(() {
                  _selectedCategoryIndex = selected ? index : 0;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedProducts(bool isDarkMode, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Destacados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              TextButton(
                onPressed: _viewAllFeatured,
                child: Text(
                  'Ver todos',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _featuredProducts.length,
              itemBuilder: (context, index) {
                final product = _featuredProducts[index];
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(
                    right: index == _featuredProducts.length - 1 ? 0 : 15,
                  ),
                  child: _buildProductCard(product, isDarkMode, primaryColor),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    Map<String, dynamic> product,
    bool isDarkMode,
    Color primaryColor,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/products/${product['image']}.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.devices,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Información del producto
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['category'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8),

                    // Precio y descuento
                    Row(
                      children: [
                        Text(
                          product['price'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (product['originalPrice'] != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            product['originalPrice'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              product['discount'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),

                    // Rating
                    if (product['rating'] != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            '${product['rating']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${product['reviews']})',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          // Botón de favorito
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  product['isFavorite']
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 20,
                  color: product['isFavorite'] ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  _toggleFavorite(product);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewArrivals(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nuevos Lanzamientos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.85,
            ),
            itemCount: _newArrivals.length,
            itemBuilder: (context, index) {
              final product = _newArrivals[index];
              return _buildNewArrivalCard(product, isDarkMode);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNewArrivalCard(Map<String, dynamic> product, bool isDarkMode) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge "Nuevo"
          if (product['isNew'])
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'NUEVO',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Imagen
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Colors.grey[100],
              ),
              child: Center(
                child: Icon(
                  Icons.shopping_bag,
                  size: 50,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),

          // Información
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  product['category'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  product['price'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularBrands(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Marcas Populares',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _brands.length,
              itemBuilder: (context, index) {
                final brand = _brands[index];
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(
                    right: index == _brands.length - 1 ? 0 : 15,
                  ),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[100],
                          ),
                          child: Center(
                            child: Text(
                              brand['name'][0],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          brand['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${brand['products']} productos',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialOffers(bool isDarkMode, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ofertas Especiales',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColor.withOpacity(0.9),
                  primaryColor.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Black Friday',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Hasta 50% de descuento en electrónicos seleccionados',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _viewBlackFridayDeals,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Ver Ofertas',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.local_offer,
                      size: 60,
                      color: Colors.white,
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

  // Métodos de la lógica
  void _showFilters() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filtrar Productos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildFilterOption('Precio', 'Cualquier precio'),
              _buildFilterOption('Marca', 'Todas las marcas'),
              _buildFilterOption('Condición', 'Nuevo y usado'),
              _buildFilterOption('Entrega', 'Todos los métodos'),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _applyFilters();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Aplicar Filtros',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value),
              const Icon(Icons.arrow_drop_down, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  void _toggleFavorite(Map<String, dynamic> product) {
    setState(() {
      product['isFavorite'] = !product['isFavorite'];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          product['isFavorite']
              ? 'Agregado a favoritos'
              : 'Removido de favoritos',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _viewAllFeatured() {
    // Navegar a pantalla de todos los destacados
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mostrando todos los productos destacados'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _viewBlackFridayDeals() {
    // Navegar a ofertas de Black Friday
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cargando ofertas de Black Friday'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _applyFilters() {
    // Aplicar filtros seleccionados
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filtros aplicados'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
