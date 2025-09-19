import 'package:flutter/material.dart';

// Mock service data
const serviceDetails = {
  '1': {
    'id': 1,
    'title': 'Building Permits',
    'description':
        'Easily apply for the the residential and and commercial building permits online. Our streamlined processs makes it easy to get the permits you need for your construction projects.',
    'category': 'permits',
    'status': 'online',
    'processingTime': '5-10 business days',
    'fee': '\$50-\$500',
    'hasVideo': true,
    'icon': Icons.account_balance,
    'color': '#059669',
    'requirements': [
      'Property deed or lease agreement',
      'Detailed construction plans',
      'Site survey (if applicable)',
      'Contractor license information',
      'Environmental impact assessment (for large projects)',
    ],
    'steps': [
      'Complete the online application form',
      'Upload required documents',
      'Pay application fee',
      'Schedule inspection (if required)',
      'Receive permit approval',
    ],
    'documents': [
      {
        'name': 'Building Permit Application Form',
        'type': 'PDF',
        'size': '2.3 MB'
      },
      {'name': 'Construction Guidelines', 'type': 'PDF', 'size': '1.8 MB'},
      {'name': 'Fee Schedule', 'type': 'PDF', 'size': '0.5 MB'},
    ],
    'contact': {
      'department': 'Planning & Zoning',
      'phone': '(555) 123-4900',
      'email': 'permits@springfield.gov',
      'office': 'City Hall - Room 205',
      'hours': 'Mon-Fri 8:30 AM - 4:30 PM',
    },
    'faq': [
      {
        'question': 'How long does it take to get a building permit?',
        'answer':
            'Most building permits are processed within 5-10 business days. Complex projects may take longer.',
      },
      {
        'question': 'What happens if my application is rejected?',
        'answer':
            'You will receive detailed feedback on what needs to be corrected. You can resubmit once issues are addressed.',
      },
      {
        'question': 'Can I start construction before receiving the permit?',
        'answer':
            'No, construction cannot begin until the permit is approved and issued. Starting without a permit may result in fines.',
      },
    ],
  },
};

class ServiceDetailScreen extends StatefulWidget {
  final String id;

  const ServiceDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  bool showVideo = false;
  final Map<int, bool> faqExpanded = {};

  @override
  Widget build(BuildContext context) {
    final service = serviceDetails[widget.id];

    if (service == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Service not found',
                  style: TextStyle(
                   
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF475569),
                    height: 1.5,
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
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          service['title'] as String,
          style: const TextStyle(
           
            fontSize: 22,
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
            // Service Description
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xff059669),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildStatusBadge(service['status'] as String),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    service['description'] as String,
                    style: const TextStyle(
                     
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF475569),
                      height: 1.5,
                     
                    ),
                     textAlign:TextAlign.left
                  ),
                ],
              ),
            ),
            // Quick Info
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Information',
                    style: TextStyle(
                     
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickInfoItem(
                          icon: Icons.access_time,
                          label: 'Processing Time',
                          value: service['processingTime'] as String,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildQuickInfoItem(
                          icon: Icons.money,
                          label: 'Fee',
                          value: service['fee'] as String,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Video Tutorial
            if (service['hasVideo'] as bool)
              Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Video Tutorial',
                      style: TextStyle(
                       
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => setState(() => showVideo = true),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'https://images.pexels.com/photos/3182774/pexels-photo-3182774.jpeg?auto=compress&cs=tinysrgb&w=600',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 76,
                            left: MediaQuery.of(context).size.width / 2 - 44,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            // Requirements
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Requirements',
                    style: TextStyle(
                     
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...((service['requirements'] as List<dynamic>)
                      .map((requirement) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Color(0xFF059669),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    requirement as String,
                                    style: const TextStyle(
                                     
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF374151),
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))),
                ],
              ),
            ),
            // Process Steps
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Application Process',
                    style: TextStyle(
                     
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...((service['steps'] as List<dynamic>)
                      .asMap()
                      .entries
                      .map((entry) {
                    final index = entry.key;
                    final step = entry.value as String;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E40AF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                 
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              step,
                              style: const TextStyle(
                               
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF374151),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
                ],
              ),
            ),
            // Documents
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Required Documents',
                    style: TextStyle(
                     
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...((service['documents'] as List<dynamic>).map((document) =>
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.description,
                              size: 20,
                              color: Color(0xFF1E40AF),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document['name'] as String,
                                    style: const TextStyle(
                                     
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF1F2937),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${document['type']} • ${document['size']}',
                                    style: const TextStyle(
                                     
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF475569),
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.file_download_outlined,
                              size: 18,
                              color: Color(0xFF475569),
                            ),
                          ],
                        ),
                      ))),
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
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
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
                          (service as Map<String, dynamic>)['contact']
                              ['department'] as String,
                          style: const TextStyle(
                           
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildContactItem(
                          icon: Icons.phone_outlined,
                          text: (service as Map<String, dynamic>)['contact']
                              ['phone'],
                        ),
                        _buildContactItem(
                          icon: Icons.email_outlined,
                          text: (service as Map<String, dynamic>)['contact']
                              ['email'],
                        ),
                        _buildContactItem(
                          icon: Icons.account_balance_outlined,
                          text: (service as Map<String, dynamic>)['contact']
                              ['office'],
                        ),
                        _buildContactItem(
                          icon: Icons.access_time,
                          text: (service as Map<String, dynamic>)['contact']
                              ['hours'],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // FAQ
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                     
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...((service['faq'] as List<dynamic>)
                      .asMap()
                      .entries
                      .map((entry) {
                    final index = entry.key;
                    final faq = entry.value as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          faqExpanded[index] = !(faqExpanded[index] ?? false);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
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
                              faq['question'] as String,
                              style: const TextStyle(
                               
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            if (faqExpanded[index] ?? false) ...[
                              const SizedBox(height: 8),
                              Text(
                                faq['answer'] as String,
                                style: const TextStyle(
                                 
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF475569),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  })),
                ],
              ),
            ),
            // Action Buttons
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E40AF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: const Color(0xFF1E40AF),
                      elevation: 0,
                    ),
                    child: const Center(
                      child: Text(
                        'Start Application',
                        style: TextStyle(
                         
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
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

  Widget _buildStatusBadge(String status) {
    final statusConfig = {
      'online': {
        'color': const Color(0xFF059669),
        'bgColor': const Color(0xFFECFDF5),
        'text': 'Available Online'
      },
      'in-person': {
        'color': const Color(0xFFEA580C),
        'bgColor': const Color(0xFFFFF7ED),
        'text': 'In-Person Required'
      },
      'offline': {
        'color': const Color(0xFFDC2626),
        'bgColor': const Color(0xFFFEF2F2),
        'text': 'Currently Unavailable'
      },
    };

    final config = statusConfig[status] ?? statusConfig['online']!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: config['bgColor'] as Color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        config['text'] as String,
        style: TextStyle(
         
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: config['color'] as Color,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildQuickInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF475569)),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
             
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF475569),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
             
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF475569)),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF374151),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}