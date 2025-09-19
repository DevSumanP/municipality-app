class EmployeeEntity {
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

  const EmployeeEntity({
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EmployeeEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}