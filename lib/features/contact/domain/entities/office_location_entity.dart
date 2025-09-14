class OfficeLocationEntity {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String hours;
  final String services;
  final Map<String, double> coordinates;

  const OfficeLocationEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.hours,
    required this.services,
    required this.coordinates,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OfficeLocationEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}