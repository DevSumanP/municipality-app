import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class QuickService {
  final int id;
  final String title;
  final IconData icon;
  final Color color;
  final Color bgColor;

  QuickService({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.bgColor,
  });
}

class NewsItem {
  final int id;
  final String title;
  final String date;
  final String category;
  final String image;

  NewsItem({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    required this.image,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';

  final List<QuickService> quickServices = [
    QuickService(
      id: 1,
      title: 'Pay Bills',
      icon: Iconsax.money,
      color: const Color(0xFF059669),
      bgColor: const Color(0xFFECFDF5),
    ),
    QuickService(
      id: 2,
      title: 'Permits',
      icon: Iconsax.document,
      color: const Color(0xFFDC2626),
      bgColor: const Color(0xFFFEF2F2),
    ),
    QuickService(
      id: 3,
      title: 'Parking',
      icon: Iconsax
          .truck, // Note: Iconsax lacks a direct 'Car' icon, using 'truck' as a substitute
      color: const Color(0xFF7C3AED),
      bgColor: const Color(0xFFF3E8FF),
    ),
    QuickService(
      id: 4,
      title: 'Property',
      icon: Iconsax.building,
      color: const Color(0xFFEA580C),
      bgColor: const Color(0xFFFFFBEB),
    ),
    QuickService(
      id: 5,
      title: 'Report Issue',
      icon: Iconsax.danger,
      color: const Color(0xFFB45309),
      bgColor: const Color(0xFFFFFBEB),
    ),
    QuickService(
      id: 6,
      title: 'Emergency',
      icon: Iconsax.shield,
      color: const Color(0xFFDC2626),
      bgColor: const Color(0xFFFEF2F2),
    ),
  ];

  final List<NewsItem> newsItems = [
    NewsItem(
      id: 1,
      title: 'New Community Center Opens Downtown',
      date: '2024-01-15',
      category: 'Community',
      image:
          'https://images.pexels.com/photos/3182774/pexels-photo-3182774.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    NewsItem(
      id: 2,
      title: 'Road Construction Updates - Main Street',
      date: '2024-01-14',
      category: 'Transportation',
      image:
          'https://images.pexels.com/photos/1109541/pexels-photo-1109541.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    NewsItem(
      id: 3,
      title: 'Water Conservation Program Launch',
      date: '2024-01-13',
      category: 'Environment',
      image:
          'https://images.pexels.com/photos/416978/pexels-photo-416978.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: const BoxDecoration(
              color: Color(0xFF1E40AF),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            color: Color(0xFFBFDBFE),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Springfield City',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Iconsax.notification,
                            size: 24,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Emergency Banner
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      border:
                          Border.all(color: const Color(0xFFFECACA), width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Iconsax.danger,
                          size: 20,
                          color: Color(0xFFDC2626),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Emergency? Call 911 | Non-emergency: (555) 123-4567',
                            style: TextStyle(
                              color: Color(0xFF991B1B),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quick Services
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Quick Services',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: quickServices
                              .map((service) => SizedBox(
                                    width: (screenWidth - 56) / 2,
                                    child: ServiceCard(service: service),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),

                  // Latest News
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Latest News',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'View All',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1E40AF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: newsItems
                                .map((item) => NewsCard(item: item))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Important Links
                  const Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Important Links',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              LinkItem(
                                icon: Iconsax.document,
                                text: 'City Council Meetings',
                              ),
                              SizedBox(height: 8),
                              LinkItem(
                                icon: Iconsax.building,
                                text: 'Public Records',
                              ),
                              SizedBox(height: 8),
                              LinkItem(
                                icon: Iconsax.call,
                                text: 'Department Directory',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final QuickService service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: service.bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: service.color,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                service.icon,
                size: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              service.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsItem item;

  const NewsCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                item.image,
                width: 280,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 280,
                    height: 140,
                    color: const Color(0xFFF3F4F6),
                    child: const Icon(
                      Icons.image,
                      size: 40,
                      color: Color(0xFF64748B),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.category.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF1E40AF),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            DateFormat('MM/dd/yyyy')
                                .format(DateTime.parse(item.date)),
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                          height: 1.375, // 22/16
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Iconsax.arrow_right2,
                      size: 16,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinkItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const LinkItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: const Color(0xFF1E40AF),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151),
                ),
              ),
            ),
            const Icon(
              Iconsax.arrow_right2,
              size: 16,
              color: Color(0xFF64748B),
            ),
          ],
        ),
      ),
    );
  }
}
