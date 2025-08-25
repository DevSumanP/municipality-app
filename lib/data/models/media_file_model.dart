class MediaFileModel {
  final int id;
  final String userId;
  final String title;
  final String type;
  final String url;
  final String? localPath;
  final bool isDownloaded;
  final String createdAt;
  final String updatedAt;

  MediaFileModel({
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

  factory MediaFileModel.fromJson(Map<String, dynamic> json) {
    return MediaFileModel(
      id: json['id'] ?? 0,
      userId: json['user_id']?.toString() ?? '',
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      url: json['url'] ?? '',
      localPath: json['local_path'],
      isDownloaded: json['is_downloaded'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'type': type,
      'url': url,
      'local_path': localPath,
      'is_downloaded': isDownloaded,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}