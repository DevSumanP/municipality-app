import 'package:municipality_app/features/contact/domain/entities/emergency_contact_entity.dart';

class EmergencyContactModel extends EmergencyContactEntity {
  const EmergencyContactModel({
    required super.id,
    required super.name,
    required super.number,
    required super.description,
    required super.icon,
    required super.iconColor,
    required super.backgroundColor,
  });

  // Convert from JSON (API response)
  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) {
    return EmergencyContactModel(
      id: json['id'] as int,
      name: json['name'] as String,
      number: json['number'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      iconColor: json['color'] as String,
      backgroundColor: json['bgColor'] as String,
    );
  }

  // Convert to JSON (for caching/API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'description': description,
      'icon': icon,
      'color': iconColor,
      'bgColor': backgroundColor,
    };
  }

  // Convert to Domain Entity
  EmergencyContactEntity toEntity() {
    return EmergencyContactEntity(
      id: id,
      name: name,
      number: number,
      description: description,
      icon: icon,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
    );
  }

  // Convert from Domain Entity
  factory EmergencyContactModel.fromEntity(EmergencyContactEntity entity) {
    return EmergencyContactModel(
      id: entity.id,
      name: entity.name,
      number: entity.number,
      description: entity.description,
      icon: entity.icon,
      iconColor: entity.iconColor,
      backgroundColor: entity.backgroundColor,
    );
  }

  // CopyWith method for immutable updates
  EmergencyContactModel copyWith({
    int? id,
    String? name,
    String? number,
    String? description,
    String? icon,
    String? iconColor,
    String? backgroundColor,
  }) {
    return EmergencyContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  String toString() {
    return 'EmergencyContactModel{id: $id, name: $name, number: $number, description: $description, icon: $icon, iconColor: $iconColor, backgroundColor: $backgroundColor}';
  }
}