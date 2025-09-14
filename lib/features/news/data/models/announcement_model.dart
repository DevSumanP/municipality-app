import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/announcement_entity.dart';

part 'announcement_model.g.dart';

@JsonSerializable()
class AnnouncementModel {
  final int id;
  final String title;
  final String date;
  final String priority;
  final String type;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.date,
    required this.priority,
    required this.type,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementModelToJson(this);

  AnnouncementEntity toEntity() {
    return AnnouncementEntity(
      id: id,
      title: title,
      date: DateTime.parse(date),
      priority: priority,
      type: type,
    );
  }

  factory AnnouncementModel.fromEntity(AnnouncementEntity entity) {
    return AnnouncementModel(
      id: entity.id,
      title: entity.title,
      date: entity.date.toIso8601String(),
      priority: entity.priority,
      type: entity.type,
    );
  }
}
