// lib/screens/home_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Smartphones',
      'icon': Icons.phone_iphone,
      'color': Colors.blue,
      'count': 45,
    },
    {
      'name': 'Laptops',
      'icon': Icons.laptop,
      'color': Colors.green,
      'count': 32,
    },
    {
      'name': 'Audio',
      'icon': Icons.headphones,
      'color': Colors.purple,
      'count': 28,
    },
    {
      'name': 'Gaming',
      'icon': Icons.videogame_asset,
      'color': Colors.orange,
      'count': 21,
    },
    {
      'name': 'Wearables',
      'icon': Icons.watch,
      'color': Colors.pink,
      'count': 19,
    },
    {
      'name': 'Accesorios',
      'icon': Icons.cable,
      'color': Colors.teal,
      'count': 56,
    },
  ];

  final List<Map<String, dynamic>> _featuredDeals = [
    {
      'title': 'Black Friday',
      'subtitle': 'Hasta 50% OFF',
      'image': 'black_friday',
      'color': Colors.black,
      'endDate': 'Termina en 3 días',
    },
    {
      'title': 'Nuevos Lanzamientos',
      'subtitle': 'Tecnología 2024',
      'image': 'new_products',
      'color': Colors.blue,
      'endDate': 'Oferta limitada',
    },
    {
      'title': 'Apple Week',
      'subtitle': 'Descuentos exclusivos',
      'image': 'apple_week',
      'color': Colors.grey[800]!,
      'endDate': 'Solo esta semana',
    },
  ];

  final List<Map<String, dynamic>> _trendingProducts = [
    {
      'name': 'iPhone 15 Pro',
      'brand': 'Apple',
      'price': '\$1,199',
      'rating': 4.8,
      'image': 'iphone15',
      'isNew': true,
    },
    {
      'name': 'MacBook Air M2',
      'brand': 'Apple',
      'price': '\$999',
      'rating': 4.7,
      'image': 'macbook_air',
      'isNew': false,
    },
    {
      'name': 'Sony WH-1000XM5',
      'brand': 'Sony',
      'price': '\$399',
      'rating': 4.9,
      'image': 'sony_headphones',
      'isNew': true,
    },
  ];

  final List<Map<String, dynamic>> _recentlyViewed = [
    {
      'name': 'Samsung S24 Ultra',
      'brand': 'Samsung',
      'price': '\$1,199',
      'image': 'samsung_s24',
      'time': 'Hace 2 horas',
    },
    {
      'name': 'PlayStation 5',
      'brand': 'Sony',
      'price': '\$499',
      'image': 'ps5',
      'time': 'Hace 1 día',
    },
    {
      'name': 'iPad Pro',
      'brand': 'Apple',
      'price': '\$1,099',
      'image': 'ipad_pro',
      'time': 'Hace 3 días',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final primaryColor = Colors.blue;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // AppBar personalizado
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: primaryColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '¡Hola, Abdias!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        'Bienvenido a TechStore',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: primaryColor),
                onPressed: _showNotifications,
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart_outlined, color: primaryColor),
                onPressed: _goToCart,
              ),
            ],
          ),

          // Contenido principal
          SliverList(
            delegate: SliverChildListDelegate([
              // Barra de búsqueda
              _buildSearchBar(isDarkMode, primaryColor),

              // Banner promocional
              _buildPromoBanner(),

              // Categorías
              _buildCategoriesSection(isDarkMode),

              // Ofertas destacadas
              _buildFeaturedDeals(isDarkMode),

              // Productos trending
              _buildTrendingProducts(isDarkMode, primaryColor),

              // Recientemente vistos
              _buildRecentlyViewed(isDarkMode),

              // Marcas destacadas
              _buildFeaturedBrands(isDarkMode),

              const SizedBox(height: 30),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanProduct,
        backgroundColor: primaryColor,
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar(bool isDarkMode, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(Icons.search, color: Colors.grey[500]),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar productos electrónicos...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
                onTap: _goToSearch,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.filter_list,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: _showFilters,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      height: 225,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade700, Colors.blue.shade900],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20,
            top: 20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'OFERTA ESPECIAL',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Tecnología del Futuro\nHasta 40% OFF',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'En smartphones, laptops y más',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _viewSpecialOffers,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Ver Ofertas',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categorías',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              TextButton(
                onPressed: _viewAllCategories,
                child: const Text(
                  'Ver todas',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Container(
                  width: 90,
                  margin: EdgeInsets.only(
                    right: index == _categories.length - 1 ? 0 : 12,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: category['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          category['icon'],
                          size: 32,
                          color: category['color'],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${category['count']} items',
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedDeals(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ofertas Destacadas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _featuredDeals.length,
              itemBuilder: (context, index) {
                final deal = _featuredDeals[index];
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(
                    right: index == _featuredDeals.length - 1 ? 0 : 16,
                  ),
                  decoration: BoxDecoration(
                    color: deal['color'],
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/deals/tech_pattern.png'),
                      fit: BoxFit.cover,
                      opacity: 0.1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            deal['endDate'],
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          deal['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          deal['subtitle'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () => _viewDeal(deal['title']),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Explorar'),
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

  Widget _buildTrendingProducts(bool isDarkMode, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Ahora',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              TextButton(
                onPressed: _viewTrendingProducts,
                child: const Text(
                  'Ver más',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Usar ListView en lugar de Column directo
          SizedBox(
            height: 360, // Altura fija para evitar overflow
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _trendingProducts.length,
              itemBuilder: (context, index) {
                final product = _trendingProducts[index];
                return Container(
                  margin: EdgeInsets.only(
                    bottom: index == _trendingProducts.length - 1 ? 0 : 12,
                  ),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          color: Colors.grey[100],
                          image: const DecorationImage(
                            image: AssetImage('assets/placeholder.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: product['isNew']
                            ? Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
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
                              )
                            : null,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                product['brand'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product['price'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${product['rating']}',
                                        style: const TextStyle(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewed(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Añadir esto
        children: [
          Text(
            'Recientemente Vistos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recentlyViewed.length,
              itemBuilder: (context, index) {
                final product = _recentlyViewed[index];
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(
                    right: index == _recentlyViewed.length - 1 ? 0 : 12,
                  ),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Añadir esto
                    children: [
                      Container(
                        height: 67,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: Colors.grey[100],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.photo,
                            size: 40,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              product['brand'],
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              product['name'],
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product['price'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  product['time'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBrands(bool isDarkMode) {
    final List<String> brands = [
      'Apple',
      'Samsung',
      'Sony',
      'Dell',
      'HP',
      'LG',
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Marcas Destacadas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    brands[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Métodos de navegación
  void _showNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mostrando notificaciones'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _goToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navegando al carrito'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _goToSearch() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abriendo búsqueda'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(25),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filtros de Búsqueda',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Aquí irían los filtros reales
              Text('Próximamente: Filtros avanzados'),
            ],
          ),
        );
      },
    );
  }

  void _viewSpecialOffers() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navegando a ofertas especiales'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _viewAllCategories() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mostrando todas las categorías'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _viewDeal(String dealName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navegando a $dealName'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _viewTrendingProducts() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mostrando todos los productos trending'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _scanProduct() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Escanear Producto'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.qr_code_scanner, size: 60, color: Colors.blue),
              SizedBox(height: 20),
              Text('Apunta la cámara al código QR del producto'),
            ],
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
                  const SnackBar(
                    content: Text('Producto escaneado exitosamente'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Escanear'),
            ),
          ],
        );
      },
    );
  }
}
