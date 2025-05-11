class StyleModel {
  const StyleModel({
    this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.sizes,
    required this.baseNeed,
  });

  final int? id;
  final String title;
  final String imageUrl;
  final String description;
  final String sizes;
  final double baseNeed;
}
