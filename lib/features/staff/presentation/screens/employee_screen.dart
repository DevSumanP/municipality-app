import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/features/staff/presentation/screens/employee_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';

// Import your entities and providers
import 'package:municipality_app/features/staff/domain/entities/employee_entity.dart';
import 'package:municipality_app/features/staff/domain/entities/department_entity.dart';
import 'package:municipality_app/shared/widgets/error_widget.dart';
import 'package:municipality_app/shared/widgets/shimmer_loading.dart';
import '../provider/employee_provider.dart';
import 'department_detail_screen.dart';

class StaffDirectoryScreen extends ConsumerStatefulWidget {
  const StaffDirectoryScreen({super.key});

  @override
  ConsumerState<StaffDirectoryScreen> createState() =>
      _StaffDirectoryScreenState();
}

class _StaffDirectoryScreenState extends ConsumerState<StaffDirectoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add search listener for real-time filtering
    _searchController.addListener(() {
      ref
          .read(staffStateProvider.notifier)
          .updateSearchQuery(_searchController.text);
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

  Widget _buildShimmerCategories() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(right: 16),
            child: const ShimmerBox(
              width: 120,
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
        // const SizedBox(height: 16),
        // const Row(
        //   children: [
        //     ShimmerBox(width: 200, height: 20),
        //   ],
        // ),
        // const SizedBox(height: 16),
        // Cards shimmer
        ...List.generate(4, (index) => const ShimmerCard()),
      ],
    );
  }

  Widget _buildDepartmentFilter(
      List<DepartmentEntity> departments, String selectedDepartment) {
    return SizedBox(
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
                  ref
                      .read(staffStateProvider.notifier)
                      .updateSelectedDepartment('all');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF1E40AF)
                        : const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'All Departments',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          isSelected ? Colors.white : const Color(0xFF64748B),
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
                ref
                    .read(staffStateProvider.notifier)
                    .updateSelectedDepartment(dept.name);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1E40AF)
                      : const Color(0xFFF3F4F6),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final staffState = ref.watch(staffStateProvider);
    final filteredEmployees = ref.watch(filteredEmployeesProvider);
    final filteredDepartments = ref.watch(filteredDepartmentsProvider);

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(color: Colors.white),
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
                      margin: const EdgeInsets.only(bottom: 16),
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
                                ref
                                    .read(staffStateProvider.notifier)
                                    .updateSelectedView('departments');
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color:
                                      staffState.selectedView == 'departments'
                                          ? Colors.white
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: staffState.selectedView ==
                                          'departments'
                                      ? [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: const Offset(0, 1),
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  'Departments',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                        staffState.selectedView == 'departments'
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                    color:
                                        staffState.selectedView == 'departments'
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
                                ref
                                    .read(staffStateProvider.notifier)
                                    .updateSelectedView('employees');
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: staffState.selectedView == 'employees'
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: staffState.selectedView ==
                                          'employees'
                                      ? [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: const Offset(0, 1),
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  'Staff',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                        staffState.selectedView == 'employees'
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                    color:
                                        staffState.selectedView == 'employees'
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
                    if (staffState.selectedView == 'employees')
                      staffState.isLoading
                          ? _buildShimmerCategories()
                          : _buildDepartmentFilter(staffState.departments,
                              staffState.selectedDepartment),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: staffState.isLoading ? 0 : 20),
                  child: Column(
                    children: [
                      // Results Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: staffState.isLoading
                            ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: ShimmerBox(width: 200, height: 20),
                            )
                            : Text(
                                staffState.selectedView == 'departments'
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
                        child: staffState.isLoading
                            ? SingleChildScrollView(
                                child: _buildShimmerContent())
                            : staffState.errorMessage != null
                                ? CustomErrorWidget(
                                    errorMsg: staffState.errorMessage!,
                                    padding: 24,
                                    onTap: () => ref
                                        .read(staffStateProvider.notifier)
                                        .refreshData(),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        staffState.selectedView == 'departments'
                                            ? filteredDepartments.length
                                            : filteredEmployees.length,
                                    itemBuilder: (context, index) {
                                      if (staffState.selectedView ==
                                          'departments') {
                                        return DepartmentCard(
                                          department:
                                              filteredDepartments[index],
                                          onCall: handleCall,
                                          onEmail: handleEmail,
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const DepartmentDetailScreen(
                                                id: '1',
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return EmployeeCard(
                                          employee: filteredEmployees[index],
                                          onCall: handleCall,
                                          onEmail: handleEmail,
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const StaffDetailScreen(
                                                id: '2',
                                              ),
                                            ),
                                          ),
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
  final DepartmentEntity department;
  final Function(String) onCall;
  final Function(String) onEmail;
  final VoidCallback onTap;

  const DepartmentCard({
    super.key,
    required this.department,
    required this.onCall,
    required this.onEmail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse('0xFF${department.color}'));

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                    color: color,
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
                    Expanded(
                      child: Text(
                        department.location,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF374151),
                        ),
                      overflow: TextOverflow.ellipsis,
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
                      icon:
                          const Icon(Icons.phone, size: 16, color: Colors.white),
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
                      icon: const Icon(Icons.mail, size: 16, color: Colors.white),
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
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final EmployeeEntity employee;
  final Function(String) onCall;
  final Function(String) onEmail;
  final VoidCallback onTap;

  const EmployeeCard({
    super.key,
    required this.employee,
    required this.onCall,
    required this.onEmail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                      icon:
                          const Icon(Icons.phone, size: 14, color: Colors.white),
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
                      icon: const Icon(Icons.mail, size: 14, color: Colors.white),
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
      ),
    );
  }
}
