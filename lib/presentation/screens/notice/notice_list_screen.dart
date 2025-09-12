import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';


class EmergencyContact {
  final int id;
  final String name;
  final String number;
  final String description;
  final IconData icon;
  final Color color;
  final Color bgColor;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.number,
    required this.description,
    required this.icon,
    required this.color,
    required this.bgColor,
  });
}

class OfficeLocation {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String hours;
  final List<String> services;
  final Map<String, double> coordinates;

  OfficeLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.hours,
    required this.services,
    required this.coordinates,
  });
}

class QuickLink {
  final int id;
  final String title;
  final String url;
  final IconData icon;
  final Color color;

  QuickLink({
    required this.id,
    required this.title,
    required this.url,
    required this.icon,
    required this.color,
  });
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int? selectedOffice;

  final List<EmergencyContact> emergencyContacts = [
    EmergencyContact(
      id: 1,
      name: 'Emergency Services',
      number: '911',
      description: 'Fire, Police, Medical Emergency',
      icon: Iconsax.danger,
      color: const Color(0xFFDC2626),
      bgColor: const Color(0xFFFEF2F2),
    ),
    EmergencyContact(
      id: 2,
      name: 'Non-Emergency Police',
      number: '(555) 123-4567',
      description: 'Police non-emergency line',
      icon: Iconsax.call,
      color: const Color(0xFF1E40AF),
      bgColor: const Color(0xFFEFF6FF),
    ),
    EmergencyContact(
      id: 3,
      name: 'Utility Emergency',
      number: '(555) 123-4888',
      description: 'Water, gas, electrical emergencies',
      icon: Iconsax.warning_2,
      color: const Color(0xFFEA580C),
      bgColor: const Color(0xFFFFF7ED),
    ),
  ];

  final List<OfficeLocation> officeLocations = [
    OfficeLocation(
      id: 1,
      name: 'City Hall',
      address: '123 Main Street\nSpringfield, ST 12345',
      phone: '(555) 123-4500',
      email: 'info@springfield.gov',
      hours: 'Mon-Fri: 8:00 AM - 5:00 PM\nSat: 9:00 AM - 1:00 PM\nSun: Closed',
      services: ['Administration', 'Permits', 'Planning'],
      coordinates: {'lat': 40.7128, 'lng': -74.0060},
    ),
    OfficeLocation(
      id: 2,
      name: 'Public Works Department',
      address: '456 Industrial Way\nSpringfield, ST 12345',
      phone: '(555) 123-4600',
      email: 'publicworks@springfield.gov',
      hours: 'Mon-Fri: 7:00 AM - 4:00 PM\nWeekends: Emergency only',
      services: ['Utilities', 'Road Maintenance', 'Waste Management'],
      coordinates: {'lat': 40.7589, 'lng': -73.9851},
    ),
    OfficeLocation(
      id: 3,
      name: 'Recreation Center',
      address: '789 Park Avenue\nSpringfield, ST 12345',
      phone: '(555) 123-4800',
      email: 'recreation@springfield.gov',
      hours: 'Mon-Fri: 6:00 AM - 10:00 PM\nSat-Sun: 8:00 AM - 8:00 PM',
      services: ['Parks & Recreation', 'Community Programs', 'Events'],
      coordinates: {'lat': 40.7505, 'lng': -73.9934},
    ),
  ];

  final List<QuickLink> quickLinks = [
    QuickLink(
      id: 1,
      title: 'City Website',
      url: 'https://springfield.gov',
      icon: Iconsax.global,
      color: const Color(0xFF1E40AF),
    ),
    QuickLink(
      id: 2,
      title: 'Report an Issue',
      url: 'mailto:issues@springfield.gov',
      icon: Iconsax.message,
      color: const Color(0xFF059669),
    ),
    QuickLink(
      id: 3,
      title: 'Feedback & Suggestions',
      url: 'mailto:feedback@springfield.gov',
      icon: Iconsax.star,
      color: const Color(0xFF7C3AED),
    ),
  ];

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
    final Uri url = Uri.parse('https://maps.google.com/?q=${coordinates['lat']},${coordinates['lng']}');
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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Get in touch with city services',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Emergency Contacts
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24, top:24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Emergency Contacts',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...emergencyContacts.map((contact) => EmergencyCard(
                                contact: contact,
                                onCall: handleCall,
                              )),
                        ],
                      ),
                    ),

                    // Office Locations
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Office Locations',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Tap on any location for details and contact options',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...officeLocations.map((office) => OfficeCard(
                                office: office,
                                isExpanded: selectedOffice == office.id,
                                onTap: () {
                                  setState(() {
                                    selectedOffice = selectedOffice == office.id ? null : office.id;
                                  });
                                },
                                onCall: handleCall,
                                onEmail: handleEmail,
                                onDirections: handleDirections,
                              )),
                        ],
                      ),
                    ),

                    // Quick Links
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Quick Links',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: quickLinks.map((link) => SizedBox(
                                  width: (screenWidth - 56) / 2,
                                  child: QuickLinkCard(
                                    link: link,
                                    onTap: handleWebsite,
                                  ),
                                )).toList(),
                          ),
                        ],
                      ),
                    ),

                    // General Information
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'General Information',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
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
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'City of Springfield',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Serving our community since 1875 with dedication to excellence in municipal services.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF64748B),
                                    height: 1.43,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text(
                                      'Main Office:',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF374151),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '(555) 123-4500',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF1E40AF),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      'Email:',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF374151),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'info@springfield.gov',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF1E40AF),
                                      ),
                                    ),
                                  ],
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
      ),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  final EmergencyContact contact;
  final Function(String) onCall;

  const EmergencyCard({
    super.key,
    required this.contact,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onCall(contact.number),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: contact.bgColor,
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
                color: contact.color,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                contact.icon,
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
                      color: contact.color,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    contact.number,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: contact.color,
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
}

class OfficeCard extends StatelessWidget {
  final OfficeLocation office;
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
                            fontSize: 18,
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
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: office.services.map((service) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                service,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF1E40AF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )).toList(),
                      ),
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
                              Icon(Iconsax.call, size: 16),
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
                              Icon(Iconsax.message1, size: 16),
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
                              Icon(Iconsax.location, size: 16),
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
  final QuickLink link;
  final Function(String) onTap;

  const QuickLinkCard({
    super.key,
    required this.link,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                color: link.color,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                link.icon,
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
}