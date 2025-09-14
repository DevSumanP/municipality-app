class QuickLinkEntity {
  final int id;
  final String title;
  final String url;
  final String icon;
  final String color;

  const QuickLinkEntity({
    required this.id,
    required this.title,
    required this.url,
    required this.icon,
    required this.color,
  });

   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuickLinkEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}