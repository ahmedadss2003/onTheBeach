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
      id: json['id'] as int,
      categoryName: json['category_name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
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
