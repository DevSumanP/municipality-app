import '../../../../core/constants/enums.dart';
import '../../domain/entities/service_entity.dart';

class ServiceModel {
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

  ServiceModel({
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

  // Convert from JSON (API response)
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as int,
      title: json['title'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      processingTime: json['processingTime'] as String,
      fee: json['fee'] as String,
      hasVideo: json['hasVideo'] as bool? ?? false,
      icon: json['icon'],
      color: json['color'],
    );
  }

  // Convert to JSON (for caching/API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'status': status,
      'processingTime': processingTime,
      'fee': fee,
      'hasVideo': hasVideo,
      'icon': icon,
      'color': color,
    };
  }

  // Convert to Domain Entity
  ServiceEntity toEntity() {
    return ServiceEntity(
      id: id,
      title: title,
      category: category,
      description: description,
      status: status,
      processingTime: processingTime,
      fee: fee,
      hasVideo: hasVideo,
      icon: icon,
      color: color,
    );
  }

  // Convert from Domain Entity
  factory ServiceModel.fromEntity(ServiceEntity entity) {
    return ServiceModel(
      id: entity.id,
      title: entity.title,
      category: entity.category,
      description: entity.description,
      status: entity.status,
      processingTime: entity.processingTime,
      fee: entity.fee,
      hasVideo: entity.hasVideo,
      icon: entity.icon,
      color: entity.color,
    );
  }

}