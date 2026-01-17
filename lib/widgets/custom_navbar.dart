// lib/widgets/custom_navbar.dart
// ignore_for_file: unreachable_switch_default, deprecated_member_use

import 'package:flutter/material.dart';
import '../models/nav_item.dart';

class CustomNavBar extends StatelessWidget {
  final List<NavItem> navItems;
  final Function(int) onItemSelected;
  final int currentIndex;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final double elevation;
  final bool showLabels;
  final NavBarType type;

  const CustomNavBar({
    super.key,
    required this.navItems,
    required this.onItemSelected,
    this.currentIndex = 0,
    this.backgroundColor = Colors.white,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.elevation = 8.0,
    this.showLabels = true,
    this.type = NavBarType.bottom,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case NavBarType.bottom:
        return _buildBottomNavBar();
      case NavBarType.top:
        return _buildTopAppBar(context);
      case NavBarType.side:
        return _buildSideNavBar();
      default:
        return _buildBottomNavBar();
    }
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onItemSelected,
        backgroundColor: backgroundColor,
        selectedItemColor: activeColor,
        unselectedItemColor: inactiveColor,
        showSelectedLabels: showLabels,
        showUnselectedLabels: showLabels,
        elevation: elevation,
        type: BottomNavigationBarType.fixed,
        items: navItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(
              item.icon,
              color: currentIndex == navItems.indexOf(item)
                  ? activeColor
                  : inactiveColor,
            ),
            label: showLabels ? item.label : null,
            backgroundColor: backgroundColor,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Mi App'),
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: true,
      actions: [
        // Puedes agregar acciones adicionales aquí
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isActive = index == currentIndex;

              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? activeColor.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: isActive
                        ? Border.all(color: activeColor, width: 1)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item.icon,
                        size: 20,
                        color: isActive ? activeColor : inactiveColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: isActive ? activeColor : inactiveColor,
                          fontWeight: isActive
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSideNavBar() {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo o header
          Container(
            padding: const EdgeInsets.all(20),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mi Aplicación',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Versión 1.0.0',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(),
          // Items de navegación
          Expanded(
            child: ListView.builder(
              itemCount: navItems.length,
              itemBuilder: (context, index) {
                final item = navItems[index];
                final isActive = index == currentIndex;

                return ListTile(
                  leading: Icon(
                    item.icon,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                  title: Text(
                    item.label,
                    style: TextStyle(
                      color: isActive ? activeColor : inactiveColor,
                      fontWeight: isActive
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  selected: isActive,
                  selectedTileColor: activeColor.withOpacity(0.1),
                  onTap: () => onItemSelected(index),
                );
              },
            ),
          ),
          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            child: const Column(
              children: [
                Divider(),
                SizedBox(height: 8),
                Text(
                  '© 2024 Mi Empresa',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum NavBarType { bottom, top, side }
