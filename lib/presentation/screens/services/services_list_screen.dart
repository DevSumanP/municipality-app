import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:municipality_app/core/database/app_database.dart';
import '../../providers/database_provider.dart';

class ServicesListScreen extends ConsumerWidget {
  const ServicesListScreen({super.key});

  Map<String, dynamic> getStatusInfo(String status) {
    switch (status) {
      case 'available':
        return {
          "color": Colors.green[700],
          "bg": Colors.green[50],
          "text": "Available"
        };
      case 'maintenance':
        return {
          "color": Colors.amber[700],
          "bg": Colors.amber[50],
          "text": "Maintenance"
        };
      case 'limited':
        return {
          "color": Colors.red[700],
          "bg": Colors.red[50],
          "text": "Limited Access"
        };
      default:
        return {
          "color": Colors.green[700],
          "bg": Colors.green[50],
          "text": "Active"
        };
    }
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case 'IT Support':
        return Colors.blue;
      case 'Infrastructure':
        return Colors.purple;
      case 'Security':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(appDatabaseProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
            'Services',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 18),
          ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Status Overview
              Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 1,
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Service Status",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111827)),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatusItem(color: Colors.green, text: "4 Available"),
                          _StatusItem(
                              color: Colors.amber, text: "1 Maintenance"),
                          _StatusItem(color: Colors.red, text: "1 Limited"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Services List
              FutureBuilder<List<ServicesTable>>(
                future: database.servicesDao.getAllServices(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No services available'));
                  }

                  final services = snapshot.data!;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF6FF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Iconsax.setting,
                                        color: Colors.blue, size: 24),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(service.title,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF111827))),
                                        const SizedBox(height: 4),
                                        Text(service.description,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF6B7280),
                                                height: 1.4),
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,),
                                          
                                      ],
                                    ),
                                  ),
                                  const Icon(Iconsax.arrow_right_14,
                                      color: Color(0xFF9CA3AF), size: 20),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color:
                                          getStatusInfo(service.status)["bg"],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      getStatusInfo(service.status)["text"],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: getStatusInfo(
                                              service.status)["color"]),
                                    ),
                                  ),
                                  if (service.status == "maintenance")
                                    const Row(
                                      children: [
                                        Icon(Iconsax.clock,
                                            color: Colors.amber, size: 12),
                                        SizedBox(width: 4),
                                        Text("Back at 6 PM",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.amber)),
                                      ],
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              // Emergency Contact
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFECACA)),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Need Immediate Help?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFDC2626)),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFDC2626),
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      child: const Column(
                        children: [
                          Text("Call IT Emergency Line",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(height: 2),
                          Text("+1 (555) 911-TECH",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16,)
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final Color color;
  final String text;

  const _StatusItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(4)),
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
