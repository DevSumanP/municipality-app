import '../../domain/entities/office_location_entity.dart';

class OfficeLocationModel extends OfficeLocationEntity {
  const OfficeLocationModel({
    required super.id,
    required super.name,
    required super.address,
    required super.phone,
    required super.email,
    required super.hours,
    required super.services,
    required super.coordinates,
  });

  // Convert from JSON (API response)
  factory OfficeLocationModel.fromJson(Map<String, dynamic> json) {
    return OfficeLocationModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      hours: json['hours'] as String,
      services: json['services'] as String,
      coordinates: {
        'lat': (json['coordinates_lat'] as num).toDouble(),
        'lng': (json['coordinates_lng'] as num).toDouble(),
      },
    );
  }

  // Convert to JSON (for caching/API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'hours': hours,
      'services': services,
      'coordinates': coordinates,
    };
  }

  // Convert to Domain Entity
  OfficeLocationEntity toEntity() {
    return OfficeLocationEntity(
      id: id,
      name: name,
      address: address,
      phone: phone,
      email: email,
      hours: hours,
      services: services,
      coordinates: coordinates,
    );
  }

  // Convert from Domain Entity
  factory OfficeLocationModel.fromEntity(OfficeLocationEntity entity) {
    return OfficeLocationModel(
      id: entity.id,
      name: entity.name,
      address: entity.address,
      phone: entity.phone,
      email: entity.email,
      hours: entity.hours,
      services: entity.services,
      coordinates: entity.coordinates,
    );
  }

  // CopyWith method for immutable updates
  OfficeLocationModel copyWith({
    int? id,
    String? name,
    String? address,
    String? phone,
    String? email,
    String? hours,
    String? services,
    Map<String, double>? coordinates,
  }) {
    return OfficeLocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      hours: hours ?? this.hours,
      services: services ?? this.services,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  @override
  String toString() {
    return 'OfficeLocationModel{id: $id, name: $name, address: $address, phone: $phone, email: $email, hours: $hours, services: $services, coordinates: $coordinates}';
  }
}
