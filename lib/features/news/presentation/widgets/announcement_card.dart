import 'package:flutter/material.dart';
import 'package:municipality_app/features/news/domain/entities/announcement_entity.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementEntity announcement;

  const AnnouncementCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, Color>> priorityColors = {
      'high': {
        'bg': const Color(0xFFFEF2F2),
        'border': const Color(0xFFFECACA),
        'text': const Color(0xFF991B1B),
      },
      'medium': {
        'bg': const Color(0xFFFFFBEB),
        'border': const Color(0xFFFED7AA),
        'text': const Color(0xFF92400E),
      },
      'low': {
        'bg': const Color(0xFFF0F9FF),
        'border': const Color(0xFFBFDBFE),
        'text': const Color(0xFF1E40AF),
      },
    };

    final colors = priorityColors[announcement.priority]!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors['bg'],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors['border']!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  announcement.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors['text'],
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 16,
                color: colors['text'],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            (announcement.date).toString().substring(0, 10),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colors['text'],
            ),
          ),
        ],
      ),
    );
  }
}
