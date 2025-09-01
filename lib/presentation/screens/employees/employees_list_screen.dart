import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../providers/database_provider.dart';

class EmployeesListScreen extends ConsumerWidget {
  const EmployeesListScreen({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case '1':
        return const Color(0xff2563EB);
      case '0':
        return Colors.grey;
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
            'Employees',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 18),
          ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: FutureBuilder<List<EmployeesTable>>(
        future: database.employeesDao.getAllEmployees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text('No employees available')),
            );
          }
          final employees = snapshot.data!.toList();

          return // Employee list
              Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return Card(
                  color: const Color(0xffF9FAFB),
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    employee.imageUrl ?? '',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: getStatusColor(employee.status),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    employee.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF111827)),
                                  ),
                                  Text(
                                    employee.designationId,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2563EB),
                                    ),
                                  ),
                                  // const Text(
                                  //   'Employeee',
                                  //   style: TextStyle(
                                  //     fontSize: 12,
                                  //     color: Color(0xFF9CA3AF),
                                  //   ),
                                  // ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.email,
                                          size: 16, color: Color(0xFF6B7280)),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          employee.email ?? 'no email address',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF6B7280)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone,
                                          size: 16, color: Color(0xFF6B7280)),
                                      const SizedBox(width: 8),
                                      Text(
                                        employee.phone ?? 'no phone number',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF6B7280)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
