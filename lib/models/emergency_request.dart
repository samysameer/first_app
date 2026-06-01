enum RequestStatus { pending, accepted, onWay, arrived, completed }
enum UrgencyLevel { critical, high, moderate }

import 'symptom.dart';
import 'request_note.dart';
import 'location_data.dart';
import 'hospital.dart';
import 'app_user.dart';

class EmergencyRequest {
  final String id;
  final String requesterName;
  final String type; // e.g., "Blood Donation", "Accident"
  final String? bloodType;
  final String description;
  final String locationAddress;
  final double latitude;
  final double longitude;
  final UrgencyLevel urgency;
  final DateTime timestamp;
  final RequestStatus status;
  final double distance; // Calculated distance from current user

  // Diagram specific attributes
  final int? requestId; // Mapped from Request_id : int
  final AppUser? user; // Many-to-1 relation with User
  List<Symptom> symptoms; // 1-to-N relation with Symptom
  List<RequestNote> requestNotes; // 1-to-N relation with Request_Note
  List<LocationData> locations; // 1-to-N relation with Location
  List<Hospital> notifiedHospitals; // 1-to-N relation with Hospital

  // Derived attribute from Occurs_at relationship
  Duration get waitingTime {
    return DateTime.now().difference(timestamp);
  }

  EmergencyRequest({
    required this.id,
    required this.requesterName,
    required this.type,
    this.bloodType,
    required this.description,
    required this.locationAddress,
    required this.latitude,
    required this.longitude,
    required this.urgency,
    required this.timestamp,
    this.status = RequestStatus.pending,
    this.distance = 0.0,
    this.requestId,
    this.user,
    List<Symptom>? symptoms,
    List<RequestNote>? requestNotes,
    List<LocationData>? locations,
    List<Hospital>? notifiedHospitals,
  })  : symptoms = symptoms ?? [],
        requestNotes = requestNotes ?? [],
        locations = locations ?? [],
        notifiedHospitals = notifiedHospitals ?? [];

  // Methods mapped from class diagram
  void addSymptom(Symptom symptom) {
    symptoms.add(symptom);
  }

  void updateLocations(LocationData location) {
    locations.add(location);
  }

  // Simple factory for mock data
  factory EmergencyRequest.mock({
    required String id,
    required String type,
    String? bloodType,
    required UrgencyLevel urgency,
    required double dist,
    required String address,
  }) {
    return EmergencyRequest(
      id: id,
      requesterName: "User $id",
      type: type,
      bloodType: bloodType,
      description: "Emergency situation requiring immediate $type support at $address.",
      locationAddress: address,
      latitude: 0.0,
      longitude: 0.0,
      urgency: urgency,
      timestamp: DateTime.now().subtract(Duration(minutes: (int.tryParse(id) ?? 1) * 5)),
      distance: dist,
    );
  }
}
