import 'package:flutter/material.dart';

extension IconFromString on String {
  IconData toIcon() {
    switch (this) {
      case 'business':
        return Icons.business;
      case 'credit_card':
        return Icons.credit_card;
      case 'direction_car':
        return Icons.directions_car;
      case 'water_drop':
        return Icons.water_drop;
      case 'delete':
        return Icons.delete;
        case 'description':
        return Icons.description;
      default:
        return Icons.business; // fallback
    }
  }
}
