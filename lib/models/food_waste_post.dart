/*
Data Transfer Object for writing to database and storing post data
*/

class FoodWastePost {
  int? date;
  String? imageURL;
  double? latitude;
  double? longitude;
  int? quantity;

  FoodWastePost();

  FoodWastePost.fromMap(postMap) {
    date = postMap['date'];
    imageURL = postMap['imageURL'];
    latitude = postMap['latitude'];
    longitude = postMap['longitude'];
    quantity = postMap['quantity'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'imageURL': imageURL,
      'latitude': latitude,
      'longitude': longitude,
      'quantity': quantity,
    };
  }

}