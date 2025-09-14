import '../../domain/entities/quick_links_entity.dart';

class QuickLinkModel extends QuickLinkEntity {
   const QuickLinkModel({
    required super.id,
    required super.title,
    required super.url,
    required super.icon,
    required super.color,
  });

  // Convert from JSON (API response)
  factory QuickLinkModel.fromJson(Map<String, dynamic> json) {
    return QuickLinkModel(
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
    );
  }

  // Convert to JSON (for caching/API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'icon': icon,
      'color': color,
    };
  }

  // Convert to Domain Entity
  QuickLinkEntity toEntity() {
    return QuickLinkEntity(
      id: id,
      title: title,
      url: url,
      icon: icon,
      color: color,
    );
  }

  // Convert from Domain Entity
  factory QuickLinkModel.fromEntity(QuickLinkEntity entity) {
    return QuickLinkModel(
      id: entity.id,
      title: entity.title,
      url: entity.url,
      icon: entity.icon,
      color: entity.color,
    );
  }

  // CopyWith method for immutable updates
  QuickLinkModel copyWith({
    int? id,
    String? title,
    String? url,
    String? icon,
    String? color,
  }) {
    return QuickLinkModel(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'QuickLinkModel{id: $id, title: $title, url: $url, icon: $icon, color: $color}';
  }
}