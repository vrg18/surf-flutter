import 'package:flutter/material.dart';

/// Категория места (ресторан, музей, театр и пр.)
class Category {
  final String name;
  final IconData icon;
  bool selected;

  Category(this.name, this.icon, this.selected);

  @override
  String toString() {
    return name;
  }

  String toStringLowerCase() {
    return name.toLowerCase();
  }
}
