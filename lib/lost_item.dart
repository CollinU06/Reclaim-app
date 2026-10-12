class LostItem(this.poster, this.imagePath, this.description, this.isFound){
  final String poster;
  final String imagePath;
  final List<String> description;
  final bool isFound;

  String getPoster(){
    return poster;
  }

  String getImagePath(){
    return imagePath;
  }
  
  List<String> getDescription(){
    return description;
  }

  String descriptionAsString(){
    String result = '';
    for (int str = 0; str < description.length; str++){
      result += '${description[str]}\n';
    }
    return result;
  }

  bool wasFound(){
    return isFound;
  }
}