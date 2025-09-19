import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Mock staff data
const staffDetails = {
  '2': {
    'id': 2,
    'name': 'Michael Chen',
    'title': 'Public Works Director',
    'department': 'Public Works',
    'phone': '(555) 123-4601',
    'email': 'mchen@springfield.gov',
    'office': 'Public Works Building - Room 200',
    'hours': 'Mon-Fri 7:00 AM - 4:00 PM',
    'photo': 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=400',
    'bio': 'Michael Chen has been serving as the Public Works Director for Springfield since 2018. With over 20 years of experience in municipal engineering and infrastructure management, he oversees all aspects of the city\'s public works operations, including road maintenance, water systems, and waste management.',
    'education': [
      'Master of Civil Engineering - State University (2003)',
      'Bachelor of Engineering - Tech Institute (2001)',
      'Professional Engineer License - State Board (2005)',
    ],
    'experience': [
      {
        'position': 'Public Works Director',
        'organization': 'City of Springfield',
        'period': '2018 - Present',
        'description': 'Lead all public works operations for a city of 85,000 residents',
      },
      {
        'position': 'Assistant Public Works Director',
        'organization': 'City of Springfield',
        'period': '2015 - 2018',
        'description': 'Assisted in managing infrastructure projects and daily operations',
      },
      {
        'position': 'Senior Civil Engineer',
        'organization': 'Metro Engineering Consultants',
        'period': '2010 - 2015',
        'description': 'Designed and managed municipal infrastructure projects',
      },
    ],
    'achievements': [
      'Led the \$15M water treatment plant modernization project',
      'Implemented city-wide recycling program increasing participation by 40%',
      'Received Municipal Excellence Award from State Association (2020)',
      'Reduced infrastructure maintenance costs by 25% through preventive programs',
    ],
    'responsibilities': [
      'Oversee daily operations of Public Works Department',
      'Manage annual budget of \$12.5 million',
      'Coordinate infrastructure improvement projects',
      'Ensure compliance with environmental regulations',
      'Supervise 45 department employees',
      'Collaborate with other city departments and external agencies',
    ],
    'committees': [
      'Infrastructure Planning Committee (Chair)',
      'Emergency Response Team',
      'Budget Review Committee',
      'Environmental Sustainability Task Force',
    ],
    'availability': {
      'monday': '7:00 AM - 4:00 PM',
      'tuesday': '7:00 AM - 4:00 PM',
      'wednesday': '7:00 AM - 4:00 PM',
      'thursday': '7:00 AM - 4:00 PM',
      'friday': '7:00 AM - 4:00 PM',
      'saturday': 'Emergency only',
      'sunday': 'Emergency only',
    },
  },
};

class StaffDetailScreen extends StatefulWidget {
  final String id;

  const StaffDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _StaffDetailScreenState createState() => _StaffDetailScreenState();
}

class _StaffDetailScreenState extends State<StaffDetailScreen> {
  String selectedTab = 'overview';

  @override
  Widget build(BuildContext context) {
    final staff = staffDetails[widget.id];

    if (staff == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Staff member not found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Go Back',
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
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Staff Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Staff Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      staff['photo'] as String,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          staff['name'] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          staff['title'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E40AF),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          staff['department'] as String,
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
            // Quick Actions
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildQuickActionButton(
                      icon: Icons.phone,
                      text: 'Call',
                      color: const Color(0xFF059669),
                      onTap: () => _handleCall(staff['phone'] as String),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionButton(
                      icon: Icons.email,
                      text: 'Email',
                      color: const Color(0xFF1E40AF),
                      onTap: () => _handleEmail(staff['email'] as String),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionButton(
                      icon: Icons.message,
                      text: 'Message',
                      color: const Color(0xFF7C3AED),
                      onTap: () {}, // Message action not implemented
                    ),
                  ),
                ],
              ),
            ),
            // Tab Navigation
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  _buildTab('overview', 'Overview'),
                  _buildTab('experience', 'Experience'),
                  _buildTab('contact', 'Contact'),
                ],
              ),
            ),
            // Tab Content
            if (selectedTab == 'overview')
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      staff['bio'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF374151),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Key Responsibilities',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...((staff['responsibilities'] as List<dynamic>).map((responsibility) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                margin: const EdgeInsets.only(top: 8, right: 12),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF1E40AF),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  responsibility as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF374151),
                                    height: 1.375,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))),
                    const SizedBox(height: 24),
                    const Text(
                      'Achievements',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...((staff['achievements'] as List<dynamic>).map((achievement) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDF4),
                            borderRadius: BorderRadius.circular(8),
                            border: const Border(
                              left: BorderSide(color: Color(0xFF059669), width: 3),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Color(0xFF059669),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  achievement as String,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF374151),
                                    height: 1.33,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))),
                    const SizedBox(height: 24),
                    const Text(
                      'Committee Memberships',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...((staff['committees'] as List<dynamic>).map((committee) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            committee as String,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1E40AF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ))),
                  ],
                ),
              ),
            if (selectedTab == 'experience')
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Education',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...((staff['education'] as List<dynamic>).map((education) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.school,
                                size: 16,
                                color: Color(0xFF1E40AF),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  education as String,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF374151),
                                    height: 1.33,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))),
                    const SizedBox(height: 24),
                    const Text(
                      'Professional Experience',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...((staff['experience'] as List<dynamic>).map((exp) => Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exp['position'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                exp['organization'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1E40AF),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                exp['period'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                exp['description'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF374151),
                                  height: 1.43,
                                ),
                              ),
                            ],
                          ),
                        ))),
                  ],
                ),
              ),
            if (selectedTab == 'contact')
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildContactItem(
                            icon: Icons.phone,
                            text: staff['phone'] as String,
                            isLink: true,
                            onTap: () => _handleCall(staff['phone'] as String),
                          ),
                          _buildContactItem(
                            icon: Icons.email,
                            text: staff['email'] as String,
                            isLink: true,
                            onTap: () => _handleEmail(staff['email'] as String),
                          ),
                          _buildContactItem(
                            icon: Icons.location_on,
                            text: staff['office'] as String,
                          ),
                          _buildContactItem(
                            icon: Icons.access_time,
                            text: staff['hours'] as String,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Weekly Schedule',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: (staff['availability'] as Map<String, dynamic>)
                            .entries
                            .map((entry) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        entry.key[0].toUpperCase() + entry.key.substring(1),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF374151),
                                        ),
                                      ),
                                      Text(
                                        entry.value as String,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String tabKey, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = tabKey;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selectedTab == tabKey ? const Color(0xFF1E40AF) : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: selectedTab == tabKey ? FontWeight.w600 : FontWeight.w500,
              color: selectedTab == tabKey ? const Color(0xFF1E40AF) : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String text,
    bool isLink = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF64748B)),
          const SizedBox(width: 12),
          Expanded(
            child: isLink
                ? GestureDetector(
                    onTap: onTap,
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1E40AF),
                        decoration: TextDecoration.underline,
                        height: 1.43,
                      ),
                    ),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF374151),
                      height: 1.43,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future<void> _handleEmail(String emailAddress) async {
    final url = 'mailto:$emailAddress';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}