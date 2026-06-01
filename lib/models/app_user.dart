class AppUser {
  final int userId;
  final String firstName; // Composite Name
  final String lastName; // Composite Name
  final String email;
  final List<String> phone; // Multivalued
  final DateTime dateOfBirth;
  final DateTime registeredAt;

  AppUser({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.registeredAt,
  });

  // Derived attribute
  int get age {
    final today = DateTime.now();
    int calculatedAge = today.year - dateOfBirth.year;
    if (today.month < dateOfBirth.month || 
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      calculatedAge--;
    }
    return calculatedAge;
  }

  void submitEmergency() {
    // Implementation for Submit_Emergency() from class diagram
    print("User $firstName $lastName submitted an emergency request.");
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'registered_at': registeredAt.toIso8601String(),
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      userId: map['user_id']?.toInt() ?? 0,
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      phone: List<String>.from(map['phone'] ?? []),
      dateOfBirth: map['date_of_birth'] != null ? DateTime.parse(map['date_of_birth']) : DateTime.now(),
      registeredAt: map['registered_at'] != null ? DateTime.parse(map['registered_at']) : DateTime.now(),
    );
  }
}
