import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Mock department data
const departmentDetails = {
  '1': {
    'id': 1,
    'name': 'Public Works Department',
    'description':
        'The Public Works Department is responsible for maintaining and improving the city\'s infrastructure, including roads, water systems, waste management, and public facilities.',
    'mission':
        'To provide efficient, reliable, and sustainable infrastructure services that enhance the quality of life for all Springfield residents.',
    'location': 'Public Works Building - 456 Industrial Way',
    'phone': '(555) 123-4600',
    'email': 'publicworks@springfield.gov',
    'website': 'https://springfield.gov/publicworks',
    'hours': 'Monday-Friday: 7:00 AM - 4:00 PM\nWeekends: Emergency only',
    'employeeCount': 45,
    'budget': '\$12.5 million',
    'established': '1952',
    'image':
        'https://images.pexels.com/photos/1109541/pexels-photo-1109541.jpeg?auto=compress&cs=tinysrgb&w=800',
    'services': [
      'Road Maintenance and Construction',
      'Water and Sewer Systems',
      'Waste Collection and Recycling',
      'Street Lighting',
      'Snow Removal',
      'Park Maintenance',
      'Traffic Signal Maintenance',
      'Storm Water Management',
    ],
    'divisions': [
      {
        'name': 'Streets Division',
        'description':
            'Maintains city streets, sidewalks, and traffic infrastructure',
        'employees': 15,
      },
      {
        'name': 'Water Division',
        'description':
            'Manages water treatment, distribution, and quality testing',
        'employees': 12,
      },
      {
        'name': 'Waste Management Division',
        'description':
            'Handles garbage collection, recycling, and disposal services',
        'employees': 18,
      },
    ],
    'keyStaff': [
      {
        'id': 2,
        'name': 'Michael Chen',
        'title': 'Public Works Director',
        'phone': '(555) 123-4601',
        'email': 'mchen@springfield.gov',
        'photo':
            'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=150',
      },
      {
        'id': 7,
        'name': 'Jennifer Martinez',
        'title': 'Assistant Director',
        'phone': '(555) 123-4602',
        'email': 'jmartinez@springfield.gov',
        'photo':
            'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg?auto=compress&cs=tinysrgb&w=150',
      },
    ],
    'recentProjects': [
      {
        'name': 'Main Street Reconstruction',
        'status': 'In Progress',
        'completion': '75%',
        'description':
            'Complete reconstruction of Main Street from 1st to 10th Avenue',
      },
      {
        'name': 'Water Treatment Plant Upgrade',
        'status': 'Completed',
        'completion': '100%',
        'description': 'Modernization of water treatment facilities',
      },
    ],
    'contact': {
      'emergencyPhone': '(555) 123-4888',
      'afterHoursPhone': '(555) 123-4889',
    },
  },
};

class DepartmentDetailScreen extends StatefulWidget {
  final String id;

  const DepartmentDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DepartmentDetailScreenState createState() => _DepartmentDetailScreenState();
}

class _DepartmentDetailScreenState extends State<DepartmentDetailScreen> {
  String selectedTab = 'overview';

  @override
  Widget build(BuildContext context) {
    final department = departmentDetails[widget.id];

    if (department == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Department not found',
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
          icon: const Icon(Icons.chevron_left, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Public Works Department',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // // Department Header
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   color: Colors.white,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         department['description'] as String,
            //         style: const TextStyle(
            //           fontSize: 14,
            //           color: Colors.black,
            //           height: 1.43,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Stats Container
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(
                    icon: Icons.group,
                    color: const Color(0xFF1E40AF),
                    value: department['employeeCount'].toString(),
                    label: 'Employees',
                  ),
                  _buildStatItem(
                    icon: Icons.account_balance,
                    color: const Color(0xFF059669),
                    value: department['established'] as String,
                    label: 'Established',
                  ),
                  _buildStatItem(
                    icon: Icons.public,
                    color: const Color(0xFF7C3AED),
                    value: department['budget'] as String,
                    label: 'Budget',
                  ),
                ],
              ),
            ),
            // Contact Information
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 8),
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
                          icon: Icons.location_on,
                          text: department['location'] as String,
                        ),
                        _buildContactItem(
                          icon: Icons.phone,
                          text: department['phone'] as String,
                          isLink: true,
                          onTap: () =>
                              _handleCall(department['phone'] as String),
                        ),
                        _buildContactItem(
                          icon: Icons.email,
                          text: department['email'] as String,
                          isLink: true,
                          onTap: () =>
                              _handleEmail(department['email'] as String),
                        ),
                        _buildContactItem(
                          icon: Icons.access_time,
                          text: department['hours'] as String,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.phone,
                          text: 'Call',
                          color: const Color(0xFF059669),
                          onTap: () =>
                              _handleCall(department['phone'] as String),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.email,
                          text: 'Email',
                          color: const Color(0xFF1E40AF),
                          onTap: () =>
                              _handleEmail(department['email'] as String),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.public,
                          text: 'Website',
                          color: const Color(0xFF7C3AED),
                          onTap: () =>
                              _handleWebsite(department['website'] as String),
                        ),
                      ),
                    ],
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
                  _buildTab('staff', 'Key Staff'),
                  _buildTab('projects', 'Projects'),
                ],
              ),
            ),
            // Tab Content
            if (selectedTab == 'overview')
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mission Statement',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      department['mission'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF374151),
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Services Provided',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...((department['services'] as List<dynamic>)
                        .map((service) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(
                                        top: 8, right: 12),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF1E40AF),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      service as String,
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
                      'Department Divisions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...((department['divisions'] as List<dynamic>)
                        .map((division) => Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xFFE5E7EB)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    division['name'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    division['description'] as String,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF64748B),
                                      height: 1.43,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${division['employees']} employees',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF1E40AF),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                  ],
                ),
              ),
            if (selectedTab == 'staff')
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Key Staff Members',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...((department['keyStaff'] as List<dynamic>)
                        .map((staff) => GestureDetector(
                              onTap: () {
                                // Navigate to staff detail screen
                                // Navigator.pushNamed(context, '/directory/staff/${staff['id']}');
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color(0xFFE5E7EB)),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image.network(
                                        staff['photo'] as String,
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            staff['name'] as String,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1F2937),
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            staff['title'] as String,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF64748B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Color(0xFF64748B),
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
            if (selectedTab == 'projects')
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Projects',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...((department['recentProjects'] as List<dynamic>)
                        .map((project) => Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xFFE5E7EB)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          project['name'] as String,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1F2937),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color:
                                              project['status'] == 'Completed'
                                                  ? const Color(0xFFECFDF5)
                                                  : const Color(0xFFFFF7ED),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          project['status'] as String,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                project['status'] == 'Completed'
                                                    ? const Color(0xFF059669)
                                                    : const Color(0xFFEA580C),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    project['description'] as String,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF64748B),
                                      height: 1.43,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Progress: ${project['completion']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF374151),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE5E7EB),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: double.parse(
                                              (project['completion'] as String)
                                                  .replaceAll('%', '')) /
                                          100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF059669),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                  ],
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
          ),
        ),
      ],
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

  Widget _buildActionButton({
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
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 4),
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
                color: selectedTab == tabKey
                    ? const Color(0xFF1E40AF)
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight:
                  selectedTab == tabKey ? FontWeight.w600 : FontWeight.w500,
              color: selectedTab == tabKey
                  ? const Color(0xFF1E40AF)
                  : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Future<void> _handleEmail(String emailAddress) async {
    final url = 'mailto:$emailAddress';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Future<void> _handleWebsite(String website) async {
    if (await canLaunch(website)) {
      await launch(website);
    }
  }
}
