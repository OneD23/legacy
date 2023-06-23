class Jet {
  final String id;
  final String name;
  final String description;
  final String passengers;
  final String cabinDimensions;
  final String range;
  final String speed;
  final String cargoCapacity;
  final String imageFrom;
  final dynamic gallery;
  final String imageUrl; // Nueva propiedad para la URL de la imagen

  Jet({
    required this.id,
    required this.name,
    required this.description,
    required this.passengers,
    required this.cabinDimensions,
    required this.range,
    required this.speed,
    required this.cargoCapacity,
    required this.imageFrom,
    required this.gallery,
    required this.imageUrl,
  });

  factory Jet.fromJson(Map<String, dynamic> json) {
    return Jet(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      passengers: json['passengers'],
      cabinDimensions: json['cabinDimensions'],
      range: json['range'],
      speed: json['speed'],
      cargoCapacity: json['cargoCapacity'],
      imageFrom: json['imageFrom'],
      gallery: json['gallery'],
      imageUrl: "https://properties-production.up.railway.app/getImage/" + json['imageFrom']
    );
  }
}
