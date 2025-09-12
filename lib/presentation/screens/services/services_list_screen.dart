import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceCategory {
  final String id;
  final String name;
  final Color color;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.color,
  });
}

class Service {
  final int id;
  final String title;
  final String category;
  final String description;
  final String status;
  final String processingTime;
  final String fee;
  final bool hasVideo;
  final IconData icon;
  final Color color;

  Service({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.status,
    required this.processingTime,
    required this.fee,
    required this.hasVideo,
    required this.icon,
    required this.color,
  });
}

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  String searchQuery = '';
  String selectedCategory = 'all';
  bool showFilters = false;

  final List<ServiceCategory> serviceCategories = [
    ServiceCategory(id: 'all', name: 'All Services', color: const Color(0xFF1E40AF)),
    ServiceCategory(id: 'permits', name: 'Permits', color: const Color(0xFF059669)),
    ServiceCategory(id: 'utilities', name: 'Utilities', color: const Color(0xFFDC2626)),
    ServiceCategory(id: 'transportation', name: 'Transportation', color: const Color(0xFF7C3AED)),
    ServiceCategory(id: 'public-safety', name: 'Public Safety', color: const Color(0xFFEA580C)),
  ];

  final List<Service> services = [
    Service(
      id: 1,
      title: 'Building Permits',
      category: 'permits',
      description: 'Apply for residential and commercial building permits online',
      status: 'online',
      processingTime: '5-10 business days',
      fee: '\$50-\$500',
      hasVideo: true,
      icon: Icons.business,
      color: const Color(0xFF059669),
    ),
    Service(
      id: 2,
      title: 'Utility Bill Payment',
      category: 'utilities',
      description: 'Pay water, electric, and gas bills securely online',
      status: 'online',
      processingTime: 'Instant',
      fee: 'Free',
      hasVideo: false,
      icon: Icons.credit_card,
      color: const Color(0xFFDC2626),
    ),
    Service(
      id: 3,
      title: 'Parking Permits',
      category: 'transportation',
      description: 'Apply for residential and business parking permits',
      status: 'online',
      processingTime: '2-3 business days',
      fee: '\$25-\$100',
      hasVideo: true,
      icon: Icons.directions_car,
      color: const Color(0xFF7C3AED),
    ),
    Service(
      id: 4,
      title: 'Water Service Connection',
      category: 'utilities',
      description: 'Request new water service connection for your property',
      status: 'in-person',
      processingTime: '7-14 business days',
      fee: '\$150',
      hasVideo: true,
      icon: Icons.water_drop,
      color: const Color(0xFF0891B2),
    ),
    Service(
      id: 5,
      title: 'Waste Management Services',
      category: 'utilities',
      description: 'Schedule bulk pickup and manage waste services',
      status: 'online',
      processingTime: '3-5 business days',
      fee: '\$35',
      hasVideo: false,
      icon: Icons.delete,
      color: const Color(0xFF16A34A),
    ),
    Service(
      id: 6,
      title: 'Business License',
      category: 'permits',
      description: 'Apply for new business license or renew existing one',
      status: 'online',
      processingTime: '10-15 business days',
      fee: '\$75-\$200',
      hasVideo: true,
      icon: Icons.description,
      color: const Color(0xFFCA8A04),
    ),
  ];

  List<Service> get filteredServices {
    return services.where((service) {
      final matchesSearch = service.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          service.description.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == 'all' || service.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: const Color(0xFFF8FAFC),
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Municipal Services',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Access city services and information',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF64748B),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              // Search and Filter Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                  ),
                ),
                child: Column(
                  children: [
                   

                    // Category Filters
                    SizedBox(
                      height: 36,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: serviceCategories.length,
                        itemBuilder: (context, index) {
                          final category = serviceCategories[index];
                          final isSelected = selectedCategory == category.id;
                          
                          return Container(
                            margin: EdgeInsets.only(
                              right: index < serviceCategories.length - 1 ? 12 : 20,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = category.id;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? category.color : const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Services List
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Services Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          '${filteredServices.length} service${filteredServices.length != 1 ? 's' : ''} available',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Services List
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredServices.length,
                          itemBuilder: (context, index) {
                            return ServiceCard(service: filteredServices[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Header
          Row(
            children: [
              // Service Icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: service.color,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Icon(
                  service.icon,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),

              // Service Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            service.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        if (service.hasVideo) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDBEAFE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              size: 12,
                              color: Color(0xFF1E40AF),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    StatusBadge(status: service.status),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                size: 20,
                color: Color(0xFF64748B),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Service Description
          Text(
            service.description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              height: 1.43,
            ),
          ),

          const SizedBox(height: 12),

          // Service Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 14,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    service.processingTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.credit_card,
                    size: 14,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    service.fee,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}