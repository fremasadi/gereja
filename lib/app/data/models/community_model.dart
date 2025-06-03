class Community {
  final int id;
  final String name;
  final String description;
  final String leaderName;
  final String contactPhone;
  final List<String> images;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.leaderName,
    required this.contactPhone,
    required this.images,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      leaderName: json['leader_name'],
      contactPhone: json['contact_phone'],
      images: List<String>.from(json['images']),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
