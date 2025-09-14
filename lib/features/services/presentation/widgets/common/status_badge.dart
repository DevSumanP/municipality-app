import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, dynamic>> statusConfig = {
      'online': {
        'color': const Color(0xFF059669),
        'bgColor': const Color(0xFFECFDF5),
        'text': 'Online'
      },
      'in-person': {
        'color': const Color(0xFFEA580C),
        'bgColor': const Color(0xFFFFF7ED),
        'text': 'In-Person'
      },
      'offline': {
        'color': const Color(0xFFDC2626),
        'bgColor': const Color(0xFFFEF2F2),
        'text': 'Offline'
      },
    };

    final config = statusConfig[status]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: config['bgColor'],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        config['text'],
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: config['color'],
        ),
      ),
    );
  }
}
