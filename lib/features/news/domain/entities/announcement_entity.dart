class AnnouncementEntity {
  final int id;
  final String title;
  final DateTime date;
  final String priority;
  final String type;

  const AnnouncementEntity({
    required this.id,
    required this.title,
    required this.date,
    required this.priority,
    required this.type,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnnouncementEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}