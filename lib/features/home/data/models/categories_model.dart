class CategoriesModel {
  final int id;
  final String categoryName;
  final String? description;
  final String? image;

  CategoriesModel({
    required this.id,
    required this.categoryName,
    this.description,
    this.image,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id:
          json['id'] is int
              ? json['id']
              : int.tryParse(json['id'].toString()) ?? 0, // ✅ الحماية هنا
      categoryName: json['category_name'] ?? '',
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': categoryName,
      'description': description,
      'image': image,
    };
  }
}
