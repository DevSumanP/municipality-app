
class ServiceEntity {
  final int id;
  final String title;
  final String category;
  final String description;
  final String status;
  final String processingTime;
  final String fee;
  final bool hasVideo;
  final String icon;
  final String color;

  const ServiceEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.status,
    required this.processingTime,
    required this.fee,
    required this.hasVideo,
    required this.icon,
    required this.color,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServiceEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
