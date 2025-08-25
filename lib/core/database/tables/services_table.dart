import 'package:floor/floor.dart';

@entity
class ServicesTable {
  @primaryKey
  final int id;
  final String userId;
  final int? departmentId;
  final String title;
  final String description;
  final String? proposalSample;
  final String? video;
  final String? extraDocument;
  final String status;
  final String order;
  final String createdAt;
  final String updatedAt;
  final String isUpdated;
  final String? videoUrl;
  final String? fileUrl;
  final String? extraFileUrl;
  final String? localVideoPath;
  final String? localFilePath;
  final String? localExtraFilePath;

  const ServicesTable({
    required this.id,
    required this.userId,
    this.departmentId,
    required this.title,
    required this.description,
    this.proposalSample,
    this.video,
    this.extraDocument,
    required this.status,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
    required this.isUpdated,
    this.videoUrl,
    this.fileUrl,
    this.extraFileUrl,
    this.localVideoPath,
    this.localFilePath,
    this.localExtraFilePath,
  });
}
