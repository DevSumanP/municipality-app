import 'package:floor/floor.dart';

@entity
class EmployeesTable {
  @primaryKey
  final int id;
  final String userId;
  final String designationId;
  final String categoryId;
  final int? departmentId;
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
  final String? imageUrl;
  final String? localImagePath;

  const EmployeesTable({
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
    this.imageUrl,
    this.localImagePath,
  });
}
