class HospitalAddress {
  final String street;
  final String city;
  final String zip;

  HospitalAddress({
    required this.street,
    required this.city,
    required this.zip,
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'zip': zip,
    };
  }

  factory HospitalAddress.fromMap(Map<String, dynamic> map) {
    return HospitalAddress(
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      zip: map['zip'] ?? '',
    );
  }
}

class Hospital {
  final int hospitalId;
  final String name;
  final HospitalAddress address; // Composite attribute
  final List<String> phone; // Multivalued attribute
  final double latitude;
  final double longitude;

  Hospital({
    required this.hospitalId,
    required this.name,
    required this.address,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  void receiveRequest() {
    // Implementation for Receive_Request() from class diagram
    print("Hospital $name received the emergency request.");
  }

  Map<String, dynamic> toMap() {
    return {
      'hospital_id': hospitalId,
      'name': name,
      'address': address.toMap(),
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Hospital.fromMap(Map<String, dynamic> map) {
    return Hospital(
      hospitalId: map['hospital_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      address: map['address'] != null 
          ? HospitalAddress.fromMap(map['address']) 
          : HospitalAddress(street: '', city: '', zip: ''),
      phone: List<String>.from(map['phone'] ?? []),
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }
}
