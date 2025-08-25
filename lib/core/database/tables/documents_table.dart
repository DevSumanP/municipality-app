import 'package:floor/floor.dart';

@entity
class DocumentsTable {
  @primaryKey
  final int id;
  final String userId;
  final String title;
  final String description;
  final String type; // 'notice', 'scrolling_news', 'pdf'
  final String? imageUrl;
  final String? fileUrl;
  final String? localImagePath;
  final String? localFilePath;
  final bool isDownloaded;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String isUpdated;

  const DocumentsTable({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.type,
    this.imageUrl,
    this.fileUrl,
    this.localImagePath,
    this.localFilePath,
    required this.isDownloaded,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isUpdated,
  });
}