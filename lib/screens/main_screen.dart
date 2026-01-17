// lib/screens/main_screen.dart
import 'package:flutter/material.dart';
import '../widgets/animated_navbar.dart';
import '../models/nav_item.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<NavItem> _navItems = const [
    NavItem(label: 'Inicio', icon: Icons.home_outlined, route: '/home'),
    NavItem(label: 'Explorar', icon: Icons.explore_outlined, route: '/explore'),
    NavItem(
      label: 'Favoritos',
      icon: Icons.favorite_outline,
      route: '/favorites',
    ),
    NavItem(label: 'Perfil', icon: Icons.person_outline, route: '/profile'),
    NavItem(
      label: 'Ajustes',
      icon: Icons.settings_outlined,
      route: '/settings',
    ),
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: AnimatedNavBar(
        items: _navItems,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        activeColor: _getActiveColor(),
        inactiveColor: isDarkMode ? Colors.grey[400]! : Colors.grey[600]!,
        backgroundColor: isDarkMode ? Colors.grey[850]! : Colors.white,
      ),
    );
  }

  Color _getActiveColor() {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.pink,
      Colors.purple,
      Colors.orange,
    ];
    return colors[_currentIndex];
  }
}
