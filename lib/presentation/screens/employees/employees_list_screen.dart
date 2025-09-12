import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';


class Department {
  final int id;
  final String name;
  final String description;
  final int employees;
  final String location;
  final String phone;
  final String email;
  final Color color;

  Department({
    required this.id,
    required this.name,
    required this.description,
    required this.employees,
    required this.location,
    required this.phone,
    required this.email,
    required this.color,
  });
}

class Employee {
  final int id;
  final String name;
  final String title;
  final String department;
  final String phone;
  final String email;
  final String office;
  final String hours;
  final String photo;
  final String bio;

  Employee({
    required this.id,
    required this.name,
    required this.title,
    required this.department,
    required this.phone,
    required this.email,
    required this.office,
    required this.hours,
    required this.photo,
    required this.bio,
  });
}

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  String searchQuery = '';
  String selectedView = 'departments';
  String selectedDepartment = 'all';

  final List<Department> departments = [
    Department(
      id: 1,
      name: 'Administration',
      description: 'City management and administrative services',
      employees: 12,
      location: 'City Hall - 1st Floor',
      phone: '(555) 123-4500',
      email: 'admin@springfield.gov',
      color: const Color(0xFF1E40AF),
    ),
    Department(
      id: 2,
      name: 'Public Works',
      description: 'Infrastructure maintenance and utilities',
      employees: 45,
      location: 'Public Works Building',
      phone: '(555) 123-4600',
      email: 'publicworks@springfield.gov',
      color: const Color(0xFF059669),
    ),
    Department(
      id: 3,
      name: 'Public Safety',
      description: 'Police, fire, and emergency services',
      employees: 78,
      location: 'Safety Complex',
      phone: '(555) 123-4700',
      email: 'safety@springfield.gov',
      color: const Color(0xFFDC2626),
    ),
    Department(
      id: 4,
      name: 'Parks & Recreation',
      description: 'Parks, recreation programs, and events',
      employees: 23,
      location: 'Recreation Center',
      phone: '(555) 123-4800',
      email: 'parks@springfield.gov',
      color: const Color(0xFF16A34A),
    ),
    Department(
      id: 5,
      name: 'Planning & Zoning',
      description: 'Development planning and zoning permits',
      employees: 8,
      location: 'City Hall - 2nd Floor',
      phone: '(555) 123-4900',
      email: 'planning@springfield.gov',
      color: const Color(0xFF7C3AED),
    ),
  ];

  final List<Employee> employees = [
    Employee(
      id: 1,
      name: 'Sarah Johnson',
      title: 'City Manager',
      department: 'Administration',
      phone: '(555) 123-4501',
      email: 'sjohnson@springfield.gov',
      office: 'City Hall - Room 101',
      hours: 'Mon-Fri 8:00 AM - 5:00 PM',
      photo: 'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg?auto=compress&cs=tinysrgb&w=150',
      bio: 'Sarah has been serving Springfield for over 15 years, focusing on community development and efficient city services.',
    ),
    Employee(
      id: 2,
      name: 'Michael Chen',
      title: 'Public Works Director',
      department: 'Public Works',
      phone: '(555) 123-4601',
      email: 'mchen@springfield.gov',
      office: 'Public Works Building - Room 200',
      hours: 'Mon-Fri 7:00 AM - 4:00 PM',
      photo: 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=150',
      bio: 'Michael oversees all infrastructure projects and maintains Springfield\'s utilities and roadways.',
    ),
    Employee(
      id: 3,
      name: 'Lisa Rodriguez',
      title: 'Police Chief',
      department: 'Public Safety',
      phone: '(555) 123-4701',
      email: 'lrodriguez@springfield.gov',
      office: 'Police Station - Chief\'s Office',
      hours: 'Mon-Fri 6:00 AM - 6:00 PM',
      photo: 'https://images.pexels.com/photos/1181414/pexels-photo-1181414.jpeg?auto=compress&cs=tinysrgb&w=150',
      bio: 'Chief Rodriguez has 20 years of law enforcement experience and is committed to community policing.',
    ),
    Employee(
      id: 4,
      name: 'David Park',
      title: 'Parks & Recreation Director',
      department: 'Parks & Recreation',
      phone: '(555) 123-4801',
      email: 'dpark@springfield.gov',
      office: 'Recreation Center - Office 15',
      hours: 'Mon-Fri 9:00 AM - 5:00 PM',
      photo: 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=150',
      bio: 'David develops recreational programs and maintains Springfield\'s parks and green spaces.',
    ),
    Employee(
      id: 5,
      name: 'Emily Thompson',
      title: 'Planning Director',
      department: 'Planning & Zoning',
      phone: '(555) 123-4901',
      email: 'ethompson@springfield.gov',
      office: 'City Hall - Room 205',
      hours: 'Mon-Fri 8:30 AM - 4:30 PM',
      photo: 'https://images.pexels.com/photos/1181424/pexels-photo-1181424.jpeg?auto=compress&cs=tinysrgb&w=150',
      bio: 'Emily leads Springfield\'s development planning and ensures sustainable community growth.',
    ),
    Employee(
      id: 6,
      name: 'Robert Kim',
      title: 'Finance Director',
      department: 'Administration',
      phone: '(555) 123-4502',
      email: 'rkim@springfield.gov',
      office: 'City Hall - Room 103',
      hours: 'Mon-Fri 8:00 AM - 5:00 PM',
      photo: 'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=150',
      bio: 'Robert manages the city\'s financial operations and budget planning.',
    ),
  ];

  List<Employee> get filteredEmployees {
    return employees.where((employee) {
      final matchesSearch = employee.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          employee.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          employee.department.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesDepartment = selectedDepartment == 'all' || employee.department == selectedDepartment;
      return matchesSearch && matchesDepartment;
    }).toList();
  }

  List<Department> get filteredDepartments {
    return departments.where((department) =>
        department.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
        department.description.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  void handleCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void handleEmail(String emailAddress) async {
    final Uri url = Uri.parse('mailto:$emailAddress');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
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
                      'Staff Directory',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Find and contact city employees',
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
                    
                    // View Toggle
                    Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedView = 'departments';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: selectedView == 'departments' 
                                      ? Colors.white 
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: selectedView == 'departments' ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 1),
                                      blurRadius: 2,
                                      spreadRadius: 0,
                                    ),
                                  ] : null,
                                ),
                                child: Text(
                                  'Departments',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: selectedView == 'departments' 
                                        ? FontWeight.w600 
                                        : FontWeight.w500,
                                    color: selectedView == 'departments'
                                        ? const Color(0xFF1E40AF)
                                        : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedView = 'employees';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: selectedView == 'employees' 
                                      ? Colors.white 
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: selectedView == 'employees' ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 1),
                                      blurRadius: 2,
                                      spreadRadius: 0,
                                    ),
                                  ] : null,
                                ),
                                child: Text(
                                  'Staff',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: selectedView == 'employees' 
                                        ? FontWeight.w600 
                                        : FontWeight.w500,
                                    color: selectedView == 'employees'
                                        ? const Color(0xFF1E40AF)
                                        : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Department Filter for Employees
                    if (selectedView == 'employees')
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SizedBox(
                          height: 36,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: departments.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                final isSelected = selectedDepartment == 'all';
                                return Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedDepartment = 'all';
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isSelected ? const Color(0xFF1E40AF) : const Color(0xFFF3F4F6),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'All Departments',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: isSelected ? Colors.white : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              
                              final dept = departments[index - 1];
                              final isSelected = selectedDepartment == dept.name;
                              
                              return Container(
                                margin: EdgeInsets.only(
                                  right: index < departments.length ? 12 : 20,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDepartment = dept.name;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFF1E40AF) : const Color(0xFFF3F4F6),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      dept.name,
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
                      ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Results Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          selectedView == 'departments' 
                              ? '${filteredDepartments.length} department${filteredDepartments.length != 1 ? 's' : ''}'
                              : '${filteredEmployees.length} staff member${filteredEmployees.length != 1 ? 's' : ''}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Results List
                      Expanded(
                        child: ListView.builder(
                          itemCount: selectedView == 'departments' 
                              ? filteredDepartments.length 
                              : filteredEmployees.length,
                          itemBuilder: (context, index) {
                            if (selectedView == 'departments') {
                              return DepartmentCard(
                                department: filteredDepartments[index],
                                onCall: handleCall,
                                onEmail: handleEmail,
                              );
                            } else {
                              return EmployeeCard(
                                employee: filteredEmployees[index],
                                onCall: handleCall,
                                onEmail: handleEmail,
                              );
                            }
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

class DepartmentCard extends StatelessWidget {
  final Department department;
  final Function(String) onCall;
  final Function(String) onEmail;

  const DepartmentCard({
    super.key,
    required this.department,
    required this.onCall,
    required this.onEmail,
  });

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
          // Department Header
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: department.color,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.business,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      department.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      department.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.people,
                          size: 14,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${department.employees} employees',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
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

          // Department Details
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    department.location,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    size: 16,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    department.phone,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 4),
                  child: ElevatedButton.icon(
                    onPressed: () => onCall(department.phone),
                    icon: const Icon(Icons.phone, size: 16, color: Colors.white,),
                    label: const Text('Call'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF059669),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: ElevatedButton.icon(
                    onPressed: () => onEmail(department.email),
                    icon: const Icon(Icons.mail, size: 16, color: Colors.white,),
                    label: const Text('Email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E40AF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 14,
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
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final Function(String) onCall;
  final Function(String) onEmail;

  const EmployeeCard({
    super.key,
    required this.employee,
    required this.onCall,
    required this.onEmail,
  });

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
          // Employee Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  employee.photo,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 48,
                      height: 48,
                      color: const Color(0xFFF3F4F6),
                      child: const Icon(
                        Icons.person,
                        size: 24,
                        color: Color(0xFF64748B),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      employee.title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1E40AF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      employee.department,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
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

          // Employee Details
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 14,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    employee.office,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 14,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    employee.hours,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 4),
                  child: ElevatedButton.icon(
                    onPressed: () => onCall(employee.phone),
                    icon: const Icon(Icons.phone, size: 14, color: Colors.white,),
                    label: const Text('Call'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF059669),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: ElevatedButton.icon(
                    onPressed: () => onEmail(employee.email),
                    icon: const Icon(Icons.mail, size: 14, color: Colors.white,),
                    label: const Text('Email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E40AF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 14,
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
    );
  }
}