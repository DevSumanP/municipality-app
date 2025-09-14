class EmergencyContactEntity {
  final int id;
  final String name;
  final String number;
  final String description;
  final String icon;
  final String iconColor;
  final String backgroundColor;

  const EmergencyContactEntity({
    required this.id,
    required this.name,
    required this.number,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EmergencyContactEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
