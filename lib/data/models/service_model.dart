import 'package:municipality_app/data/models/employee_model.dart';

class ServiceModel {
  final bool success;
  final String message;
  final ServiceData data;

  ServiceModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ServiceData.fromJson(json['data'] ?? {}),
    );
  }
}

class ServiceData {
  final List<Service> services;

  ServiceData({required this.services});

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      services: (json['services'] as List?)
              ?.map((e) => Service.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Service {
  final int id;
  final String userId;
  final String? departmentId;
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
  final String videoUrl;
  final String fileUrl;
  final String extraFileUrl;
  final List<ResponsiblePerson> responsiblePeople;
  final Department? department;

  Service({
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
    required this.videoUrl,
    required this.fileUrl,
    required this.extraFileUrl,
    required this.responsiblePeople,
    this.department,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? 0,
      userId: json['user_id']?.toString() ?? '',
      departmentId: json['department_id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      proposalSample: json['proposal_sample'],
      video: json['video'],
      extraDocument: json['extra_document'],
      status: json['status']?.toString() ?? '1',
      order: json['order']?.toString() ?? '0',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      isUpdated: json['is_updated']?.toString() ?? '0',
      videoUrl: json['video_url'] ?? '',
      fileUrl: json['file_url'] ?? '',
      extraFileUrl: json['extra_file_url'] ?? '',
      responsiblePeople: (json['responsible_people'] as List?)
              ?.map((e) => ResponsiblePerson.fromJson(e))
              .toList() ??
          [],
      department: json['department'] != null
          ? Department.fromJson(json['department'])
          : null,
    );
  }
}




class ResponsiblePerson {
  final int id;
  final String name;
  final String? image;
  final String? email;
  final String? phone;
  final String? roomNumber;
  final String imageUrl;

  ResponsiblePerson({
    required this.id,
    required this.name,
    this.image,
    this.email,
    this.phone,
    this.roomNumber,
    required this.imageUrl,
  });

  factory ResponsiblePerson.fromJson(Map<String, dynamic> json) {
    return ResponsiblePerson(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
      roomNumber: json['room_number'],
      imageUrl: json['image_url'] ?? '',
    );
  }
}