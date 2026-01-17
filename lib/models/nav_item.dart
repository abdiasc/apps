// lib/models/nav_item.dart
import 'package:flutter/material.dart';

// lib/models/nav_item.dart
class NavItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final String route;
  final bool isActive;
  final int badgeCount;

  const NavItem({
    required this.label,
    required this.icon,
    required this.route,
    this.activeIcon,
    this.isActive = false,
    this.badgeCount = 0,
  });

  IconData get displayIcon => isActive ? (activeIcon ?? icon) : icon;

  NavItem copyWith({
    String? label,
    IconData? icon,
    IconData? activeIcon,
    String? route,
    bool? isActive,
    int? badgeCount,
  }) {
    return NavItem(
      label: label ?? this.label,
      icon: icon ?? this.icon,
      activeIcon: activeIcon ?? this.activeIcon,
      route: route ?? this.route,
      isActive: isActive ?? this.isActive,
      badgeCount: badgeCount ?? this.badgeCount,
    );
  }
}
