class UrgentRequest {
  final String id, type, urgency, description, location, time;
  final String? bloodType;
  final double distance;
  final int matchScore;

  UrgentRequest({
    required this.id,
    required this.type,
    required this.urgency,
    this.bloodType,
    required this.description,
    required this.location,
    required this.distance,
    required this.time,
    required this.matchScore,
  });
}
