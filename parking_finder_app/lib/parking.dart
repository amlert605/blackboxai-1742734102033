class Parking {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int availableSpots;
  final double pricePerHour;
  final bool isOpen;
  final String address;

  Parking({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.availableSpots,
    required this.pricePerHour,
    required this.isOpen,
    required this.address,
  });

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      availableSpots: json['availableSpots'] as int,
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
      isOpen: json['isOpen'] as bool,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'availableSpots': availableSpots,
      'pricePerHour': pricePerHour,
      'isOpen': isOpen,
      'address': address,
    };
  }
}
