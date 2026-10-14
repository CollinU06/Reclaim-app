class LostItem {
  final String poster;
  final String imageData;
  final String itemName;
  final String category;
  final String location;
  final String contact;
  final String description;
  final bool isFound;

  LostItem({
    required this.poster,
    required this.imageData,
    required this.itemName,
    required this.category,
    required this.location,
    required this.contact,
    required this.description,
    required this.isFound,
  });

  factory LostItem.fromFirestore(
    Map<String, dynamic> data,
  ) {
    return LostItem(
      poster: data['poster'] ?? '',
      imageData: data['imageData'] ?? '',
      itemName: data['itemName'] ?? '',
      category: data['category'] ?? '',
      location: data['location'] ?? '',
      contact: data['contact'] ?? '',
      description: data['description'] ?? '',
      isFound: data['isFound'] as bool? ?? false,
    );
  }
}