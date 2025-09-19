import '../../domain/entities/department_entity.dart';

class DepartmentModel extends DepartmentEntity {
  const DepartmentModel({
    required super.id,
    required super.name,
    required super.description,
    required super.employees,
    required super.location,
    required super.phone,
    required super.email,
    required super.color,
  });

  // Convert from JSON (API response)
  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      employees: json['employees'] as int,
      location: json['location'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      color: json['color'] as String,
    );
  }

  // Convert to JSON (for caching/API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'employees': employees,
      'location': location,
      'phone': phone,
      'email': email,
      'color': color,
    };
  }

  // Convert to Domain Entity
  DepartmentEntity toEntity() {
    return DepartmentEntity(
      id: id,
      name: name,
      description: description,
      employees: employees,
      location: location,
      phone: phone,
      email: email,
      color: color,
    );
  }

  // Convert from Domain Entity
  factory DepartmentModel.fromEntity(DepartmentEntity entity) {
    return DepartmentModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      employees: entity.employees,
      location: entity.location,
      phone: entity.phone,
      email: entity.email,
      color: entity.color,
    );
  }

  // CopyWith method for immutable updates
  DepartmentModel copyWith({
    int? id,
    String? name,
    String? description,
    int? employees,
    String? location,
    String? phone,
    String? email,
    String? color,
  }) {
    return DepartmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      employees: employees ?? this.employees,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'DepartmentModel{id: $id, name: $name, description: $description, employees: $employees, location: $location, phone: $phone, email: $email, color: $color}';
  }
}