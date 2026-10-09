class LostItem(this.poster, this.imagePath, this.description, this.isFound){
  final String poster;
  final String imagePath;
  final String description;
  final bool isFound;

  String getPoster(){
    return poster;
  }

  String getImagePath(){
    return imagePath;
  }
  
  String getDescription(){
    return description;
  }

  bool wasFound(){
    return isFound;
  }
}