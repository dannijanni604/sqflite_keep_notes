class Notes {
  final int? id;
  final String title;
  final String description;
  final String createdAt;

  Notes({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      title: json['title'],
      description: json['description'],
      createdAt: json['createdAt'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
    };
  }
}
