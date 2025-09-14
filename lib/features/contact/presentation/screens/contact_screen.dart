import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

// Import your entities and providers
import 'package:municipality_app/features/contact/domain/entities/emergency_contact_entity.dart';
import 'package:municipality_app/features/contact/domain/entities/office_location_entity.dart';
import 'package:municipality_app/shared/widgets/error_widget.dart';
import 'package:municipality_app/shared/widgets/shimmer_loading.dart';

import '../../domain/entities/quick_links_entity.dart';
import '../provider/contact_provider.dart';

class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({super.key});

  @override
  ConsumerState<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends ConsumerState<ContactScreen> {
  final TextEditingController _searchController = TextEditingController();
  int? selectedOffice;
  String selectedFilter = 'all'; // 'all', 'emergency', 'offices', 'links'

  @override
  void initState() {
    super.initState();
    // Add search listener for real-time filtering
    _searchController.addListener(() {
      // Implement search functionality if needed
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // URL launching functions
  Future<void> handleCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> handleEmail(String emailAddress) async {
    final Uri url = Uri.parse('mailto:$emailAddress');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> handleDirections(Map<String, double> coordinates) async {
    final Uri url = Uri.parse(
        'https://maps.google.com/?q=${coordinates['lat']},${coordinates['lng']}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> handleWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _buildShimmerCategories() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: index < 3 ? 12 : 20),
            child: const ShimmerBox(
              width: 80,
              height: 36,
              borderRadius: 20,
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerContent() {
    return Column(
      children: [
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              ShimmerBox(width: 200, height: 20),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Emergency contacts shimmer
        ...List.generate(3, (index) => const ShimmerCard()),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              ShimmerBox(width: 150, height: 20),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Office locations shimmer
        ...List.generate(2, (index) => const ShimmerCard()),
      ],
    );
  }

  Widget _buildFilterCategories() {
    final categories = [
      {'id': 'all', 'name': 'All', 'color': '1E40AF'},
      {'id': 'emergency', 'name': 'Emergency', 'color': 'DC2626'},
      {'id': 'offices', 'name': 'Offices', 'color': '059669'},
      {'id': 'links', 'name': 'Quick Links', 'color': '7C3AED'},
    ];

    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedFilter == category['id'];

          return Container(
            margin:
                EdgeInsets.only(right: index < categories.length - 1 ? 12 : 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = category['id']!;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Color(int.parse('0xFF${category['color']}'))
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category['name']!,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final contactState = ref.watch(contactStateProvider);
    final screenWidth = MediaQuery.of(context).size.width;

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
              // Header - Always show
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(color: Colors.white),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Directory',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Connect with city services and departments',
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
                      bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
                ),
                child: Column(
                  children: [
                    // Category Filters
                    contactState.isLoading
                        ? _buildShimmerCategories()
                        : contactState.errorMessage != null
                            ? const SizedBox.shrink()
                            : _buildFilterCategories(),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: contactState.isLoading
                    ? SingleChildScrollView(
                        child: _buildShimmerContent(),
                      )
                    : contactState.errorMessage != null
                        ? CustomErrorWidget(
                            errorMsg: contactState.errorMessage!,
                            padding: 24,
                            onTap: () => ref
                                .read(contactStateProvider.notifier)
                                .refreshData(),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Emergency Contacts
                                if (selectedFilter == 'all' ||
                                    selectedFilter == 'emergency') ...[
                                  const SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      'Emergency Contacts (${contactState.emergencyContacts.length})',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1F2937),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...contactState.emergencyContacts.map(
                                    (contact) => EmergencyCard(
                                      contact: contact,
                                      onCall: handleCall,
                                    ),
                                  ),
                                ],

                                // Office Locations
                                if (selectedFilter == 'all' ||
                                    selectedFilter == 'offices') ...[
                                  const SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      'Office Locations (${contactState.officeLocations.length})',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1F2937),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      'Tap on any location for details and contact options',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ...contactState.officeLocations.map(
                                    (office) => OfficeCard(
                                      office: office,
                                      isExpanded: selectedOffice == office.id,
                                      onTap: () {
                                        setState(() {
                                          selectedOffice =
                                              selectedOffice == office.id
                                                  ? null
                                                  : office.id;
                                        });
                                      },
                                      onCall: handleCall,
                                      onEmail: handleEmail,
                                      onDirections: handleDirections,
                                    ),
                                  ),
                                ],

                                // Quick Links
                                if (selectedFilter == 'all' ||
                                    selectedFilter == 'links') ...[
                                  const SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      'Quick Links (${contactState.quickLinks.length})',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1F2937),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Wrap(
                                      spacing: 16,
                                      runSpacing: 16,
                                      children: contactState.quickLinks
                                          .map(
                                            (link) => SizedBox(
                                              width: (screenWidth - 56) / 2,
                                              child: QuickLinkCard(
                                                link: link,
                                                onTap: handleWebsite,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ],

                                const SizedBox(height: 20),
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

// Card Widgets (adapted to use entities)
class EmergencyCard extends StatelessWidget {
  final EmergencyContactEntity contact;
  final Function(String) onCall;

  const EmergencyCard({
    super.key,
    required this.contact,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    // Parse color strings to Color objects
    final iconColor = Color(int.parse('0xFF${contact.iconColor}'));
    final backgroundColor = Color(int.parse('0xFF${contact.backgroundColor}'));

    return GestureDetector(
      onTap: () => onCall(contact.number),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
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
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                _getIconFromString(contact.icon),
                size: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    contact.number,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contact.description,
                    style: const TextStyle(
                      fontSize: 14,
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

  IconData _getIconFromString(String iconName) {
    // Map string icon names to IconData
    switch (iconName.toLowerCase()) {
      case 'danger':
        return Iconsax.danger;
      case 'call':
        return Iconsax.call;
      case 'warning_2':
        return Iconsax.warning_2;
      default:
        return Iconsax.call;
    }
  }
}

class OfficeCard extends StatelessWidget {
  final OfficeLocationEntity office;
  final bool isExpanded;
  final VoidCallback onTap;
  final Function(String) onCall;
  final Function(String) onEmail;
  final Function(Map<String, double>) onDirections;

  const OfficeCard({
    super.key,
    required this.office,
    required this.isExpanded,
    required this.onTap,
    required this.onCall,
    required this.onEmail,
    required this.onDirections,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
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
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Iconsax.building,
                      size: 24,
                      color: Color(0xFF1E40AF),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          office.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          office.address,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                            height: 1.43,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
                    size: 20,
                    color: const Color(0xFF64748B),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
              ),
              child: Column(
                children: [
                  // Contact info and action buttons (same as your original)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Iconsax.call,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => onCall(office.phone),
                          child: Text(
                            office.phone,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1E40AF),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Iconsax.message1,
                        size: 16,
                        color: Color(0xFF64748B),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => onEmail(office.email),
                        child: Text(
                          office.email,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1E40AF),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Iconsax.clock,
                        size: 16,
                        color: Color(0xFF64748B),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          office.hours,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF374151),
                            height: 1.43,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Services Available:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: office.services
                              .split(',') // split the string by commas
                              .map((service) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF6FF),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      service.trim(), // remove any extra spaces
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF1E40AF),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => onCall(office.phone),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF059669),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.call, size: 16, color: Colors.white,),
                              SizedBox(width: 4),
                              Text(
                                'Call',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => onEmail(office.email),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E40AF),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.message, size: 16, color: Colors.white,),
                              SizedBox(width: 4),
                              Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => onDirections(office.coordinates),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C3AED),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.location, size: 16, color: Colors.white,),
                              SizedBox(width: 4),
                              Text(
                                'Directions',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class QuickLinkCard extends StatelessWidget {
  final QuickLinkEntity link;
  final Function(String) onTap;

  const QuickLinkCard({
    super.key,
    required this.link,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse('0xFF${link.color}'));

    return GestureDetector(
      onTap: () => onTap(link.url),
      child: Container(
        padding: const EdgeInsets.all(20),
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
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                _getIconFromString(link.icon),
                size: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              link.title,
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

  IconData _getIconFromString(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'global':
        return Iconsax.global;
      case 'message':
        return Iconsax.message;
      case 'star':
        return Iconsax.star;
      default:
        return Iconsax.link;
    }
  }
}
