// lib/widgets/animated_navbar.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../models/nav_item.dart';

class AnimatedNavBar extends StatelessWidget {
  final List<NavItem> items;
  final int currentIndex;
  final Function(int) onTap;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;

  const AnimatedNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70,
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isActive = index == currentIndex;

              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onTap(index),
                    highlightColor: activeColor.withOpacity(0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icono con animación
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive
                                ? activeColor.withOpacity(0.15)
                                : Colors.transparent,
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                item.displayIcon,
                                color: isActive ? activeColor : inactiveColor,
                                size: isActive ? 24 : 22,
                              ),
                              // Badge para notificaciones
                              if (item.badgeCount > 0)
                                Positioned(
                                  top: -6,
                                  right: -6,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.badgeCount > 9
                                            ? '9+'
                                            : item.badgeCount.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Texto optimizado
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            _optimizeLabel(item.label),
                            style: TextStyle(
                              color: isActive ? activeColor : inactiveColor,
                              fontSize: 11,
                              fontWeight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  String _optimizeLabel(String label) {
    // Mapeo de etiquetas optimizadas para mobile
    const labelMap = {
      'inicio': 'Inicio',
      'home': 'Inicio',
      'explorar': 'Explorar',
      'explore': 'Explorar',
      'favoritos': 'Fav',
      'favorites': 'Fav',
      'perfil': 'Perfil',
      'profile': 'Perfil',
      'ajustes': 'Ajustes',
      'settings': 'Ajustes',
    };

    final optimized = labelMap[label.toLowerCase()];
    return optimized ??
        (label.length > 6 ? '${label.substring(0, 5)}..' : label);
  }
}
