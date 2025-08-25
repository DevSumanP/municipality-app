class DocumentModel {
  final bool success;
  final String message;
  final DocumentData data;

  DocumentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DocumentData.fromJson(json['data'] ?? {}),
    );
  }
}

class DocumentData {
  final List<Notice>? notices;
  final List<ScrollingNews>? scrollingNews;
  final List<Video>? videos;

  DocumentData({
    this.notices,
    this.scrollingNews,
    this.videos,
  });

  factory DocumentData.fromJson(Map<String, dynamic> json) {
    return DocumentData(
      notices: json['notices'] != null
          ? (json['notices'] as List).map((e) => Notice.fromJson(e)).toList()
          : null,
      scrollingNews: json['scrollingNews'] != null
          ? (json['scrollingNews'] as List).map((e) => ScrollingNews.fromJson(e)).toList()
          : null,
      videos: json['videos'] != null
          ? (json['videos'] as List).map((e) => Video.fromJson(e)).toList()
          : null,
    );
  }
}

class Notice {
  final int id;
  final String userId;
  final String title;
  final String description;
  final String? image;
  final String? file;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String isUpdated;
  final String imageUrl;
  final String fileUrl;

  Notice({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.image,
    this.file,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isUpdated,
    required this.imageUrl,
    required this.fileUrl,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'] ?? 0,
      userId: json['user_id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      file: json['file'],
      status: json['status']?.toString() ?? '1',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      isUpdated: json['is_updated']?.toString() ?? '0',
      imageUrl: json['image_url'] ?? '',
      fileUrl: json['file_url'] ?? '',
    );
  }
}

class ScrollingNews {
  final int id;
  final String userId;
  final String title;
  final String status;
  final String createdAt;
  final String updatedAt;

  ScrollingNews({
    required this.id,
    required this.userId,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScrollingNews.fromJson(Map<String, dynamic> json) {
    return ScrollingNews(
      id: json['id'] ?? 0,
      userId: json['user_id']?.toString() ?? '',
      title: json['title'] ?? '',
      status: json['status']?.toString() ?? '1',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class Video {
  final int id;
  final String userId;
  final String title;
  final String video;
  final String videoUrl;
  final String createdAt;
  final String updatedAt;

  Video({
    required this.id,
    required this.userId,
    required this.title,
    required this.video,
    required this.videoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? 0,
      userId: json['user_id']?.toString() ?? '',
      title: json['title'] ?? '',
      video: json['video'] ?? '',
      videoUrl: json['video_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}