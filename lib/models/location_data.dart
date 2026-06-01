class LocationData {
  final int locationId;
  final double latitude;
  final double longitude;
  final String address;
  final DateTime timestamp;
  
  // Derived attribute
  double? distanceFromHospital;

  LocationData({
    required this.locationId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.timestamp,
    this.distanceFromHospital,
  });

  Map<String, dynamic> toMap() {
    return {
      'location_id': locationId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      locationId: map['location_id']?.toInt() ?? 0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      address: map['address'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
    );
  }
}
