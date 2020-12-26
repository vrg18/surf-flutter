import 'package:flutter/material.dart';

/// Категоря места (ресторан, музей, театр и пр.)
class Category {
  final String name;
  final IconData icon;

  Category(this.name, this.icon);

  @override
  String toString() {
    return name;
  }

  String toStringLowerCase() {
    return name.toLowerCase();
  }
}
