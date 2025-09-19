import '../../domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    required super.id,
    required super.name,
    required super.title,
    required super.department,
    required super.phone,
    required super.email,
    required super.office,
    required super.hours,
    required super.photo,
    required super.bio,
  });

  // Convert from JSON (API response)
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      title: json['title'] as String,
      department: json['department'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      office: json['office'] as String,
      hours: json['hours'] as String,
      photo: json['photo'] as String,
      bio: json['bio'] as String,
    );
  }

  // Convert to JSON (for caching/API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'department': department,
      'phone': phone,
      'email': email,
      'office': office,
      'hours': hours,
      'photo': photo,
      'bio': bio,
    };
  }

  // Convert to Domain Entity
  EmployeeEntity toEntity() {
    return EmployeeEntity(
      id: id,
      name: name,
      title: title,
      department: department,
      phone: phone,
      email: email,
      office: office,
      hours: hours,
      photo: photo,
      bio: bio,
    );
  }

  // Convert from Domain Entity
  factory EmployeeModel.fromEntity(EmployeeEntity entity) {
    return EmployeeModel(
      id: entity.id,
      name: entity.name,
      title: entity.title,
      department: entity.department,
      phone: entity.phone,
      email: entity.email,
      office: entity.office,
      hours: entity.hours,
      photo: entity.photo,
      bio: entity.bio,
    );
  }

  // CopyWith method for immutable updates
  EmployeeModel copyWith({
    int? id,
    String? name,
    String? title,
    String? department,
    String? phone,
    String? email,
    String? office,
    String? hours,
    String? photo,
    String? bio,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      department: department ?? this.department,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      office: office ?? this.office,
      hours: hours ?? this.hours,
      photo: photo ?? this.photo,
      bio: bio ?? this.bio,
    );
  }

  @override
  String toString() {
    return 'EmployeeModel{id: $id, name: $name, title: $title, department: $department, phone: $phone, email: $email, office: $office, hours: $hours, photo: $photo, bio: $bio}';
  }
}