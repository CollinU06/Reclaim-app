class LostItem {
  final String poster;
  final String imageData;
  final String description;
  final bool isFound;

  LostItem({
    required this.poster,
    required this.imageData,
    required this.description,
    required this.isFound,
  });

  factory LostItem.fromFirestore(Map<String, dynamic> data) {
    return LostItem(
      poster: data['poster'] ?? '',
      imageData: data['imageData'] ?? '',
      description: data['description'] ?? '',
      isFound: data['isFound'] as bool? ?? false,
    );
  }
}