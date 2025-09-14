import '../../domain/entities/service_category_entity.dart';

class ServiceCategoryModel {
  final String id;
  final String name;
  final String colorHex;

  ServiceCategoryModel({
    required this.id,
    required this.name,
    required this.colorHex,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      colorHex: json['color'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': colorHex,
    };
  }

  ServiceCategoryEntity toEntity() {
    return ServiceCategoryEntity(
      id: id,
      name: name,
      colorHex: colorHex,
    );
  }

  factory ServiceCategoryModel.fromEntity(ServiceCategoryEntity entity) {
    return ServiceCategoryModel(
      id: entity.id,
      name: entity.name,
      colorHex: entity.colorHex,
    );
  }
}