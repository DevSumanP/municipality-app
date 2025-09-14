
class ServiceCategoryEntity {
  final String id;
  final String name;
  final String colorHex;

  const ServiceCategoryEntity({
    required this.id,
    required this.name,
    required this.colorHex,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServiceCategoryEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
