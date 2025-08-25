class User {
  final int id;
  final String name;
  final String email;
  final String address;
  final String type;
  final int? wardNumber;
  final String? image;
  final String headerTitle;
  final String gisLink;
  final String? imageUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.type,
    this.wardNumber,
    this.image,
    required this.headerTitle,
    required this.gisLink,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      type: json['type'] ?? '',
      wardNumber: json['ward_number'],
      image: json['image'],
      headerTitle: json['header_title'] ?? '',
      gisLink: json['gisLink'] ?? '',
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'type': type,
      'ward_number': wardNumber,
      'image': image,
      'header_title': headerTitle,
      'gisLink': gisLink,
      'image_url': imageUrl,
    };
  }
}