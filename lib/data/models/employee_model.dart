import 'package:municipality_app/data/models/service_model.dart';

class EmployeeModel {
  final bool success;
  final String message;
  final EmployeeData data;

  EmployeeModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: EmployeeData.fromJson(json['data'] ?? {}),
    );
  }
}

class EmployeeData {
  final List<Designation> designations;
  final List<Category> categories;
  final List<Department> departments;
  final List<Employee> employees;

  EmployeeData({
    required this.designations,
    required this.categories,
    required this.departments,
    required this.employees,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      designations: (json['designations'] as List?)
          ?.map((e) => Designation.fromJson(e))
          .toList() ?? [],
      categories: (json['categories'] as List?)
          ?.map((e) => Category.fromJson(e))
          .toList() ?? [],
      departments: (json['departments'] as List?)
          ?.map((e) => Department.fromJson(e))
          .toList() ?? [],
      employees: (json['employees'] as List?)
          ?.map((e) => Employee.fromJson(e))
          .toList() ?? [],
    );
  }
}

class Employee {
  final int id;
  final String userId;
  final String designationId;
  final String categoryId;
  final String? departmentId;
  final String name;
  final String? phone;
  final String? email;
  final String? roomNumber;
  final String? image;
  final String order;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String isUpdated;
  final String imageUrl;
  final Designation designation;
  final Category category;
  final Department? department;

  Employee({
    required this.id,
    required this.userId,
    required this.designationId,
    required this.categoryId,
    this.departmentId,
    required this.name,
    this.phone,
    this.email,
    this.roomNumber,
    this.image,
    required this.order,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isUpdated,
    required this.imageUrl,
    required this.designation,
    required this.category,
    this.department,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? 0,
      userId: json['user_id']?.toString() ?? '',
      designationId: json['designation_id']?.toString() ?? '',
      categoryId: json['category_id']?.toString() ?? '',
      departmentId: json['department_id'],
      name: json['name'] ?? '',
      phone: json['phone'],
      email: json['email'],
      roomNumber: json['room_number'],
      image: json['image'],
      order: json['order']?.toString() ?? '0',
      status: json['status']?.toString() ?? '1',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      isUpdated: json['is_updated']?.toString() ?? '0',
      imageUrl: json['image_url'] ?? '',
      designation: Designation.fromJson(json['designation'] ?? {}),
      category: Category.fromJson(json['category'] ?? {}),
      department: json['department'] != null 
          ? Department.fromJson(json['department']) 
          : null,
    );
  }
}

class Designation {
  final int id;
  final String title;

  Designation({
    required this.id,
    required this.title,
  });

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
    );
  }
}

class Category {
  final int id;
  final String title;

  Category({
    required this.id,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
    );
  }
}

class Department {
  final int id;
  final String title;
  final List<Service>? services;

  Department({
    required this.id,
    required this.title,
    this.services,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      services: json['services'] != null
          ? (json['services'] as List)
              .map((e) => Service.fromJson(e))
              .toList()
          : null,
    );
  }
}