import 'package:floor/floor.dart';

@entity
class MediaFilesTable {
  @primaryKey
  final int id;
  final String userId;
  final String title;
  final String type; // 'image', 'video'
  final String url;
  final String? localPath;
  final bool isDownloaded;
  final String createdAt;
  final String updatedAt;

  const MediaFilesTable({
    required this.id,
    required this.userId,
    required this.title,
    required this.type,
    required this.url,
    this.localPath,
    required this.isDownloaded,
    required this.createdAt,
    required this.updatedAt,
  });
}
