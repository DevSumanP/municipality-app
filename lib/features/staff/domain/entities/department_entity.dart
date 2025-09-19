class DepartmentEntity {
  final int id;
  final String name;
  final String description;
  final int employees;
  final String location;
  final String phone;
  final String email;
  final String color;

  const DepartmentEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.employees,
    required this.location,
    required this.phone,
    required this.email,
    required this.color,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DepartmentEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}