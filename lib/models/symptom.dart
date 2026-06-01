class Symptom {
  final int symptomId;
  final String description;
  final int severity;

  Symptom({
    required this.symptomId,
    required this.description,
    required this.severity,
  });

  Map<String, dynamic> toMap() {
    return {
      'symptom_id': symptomId,
      'description': description,
      'severity': severity,
    };
  }

  factory Symptom.fromMap(Map<String, dynamic> map) {
    return Symptom(
      symptomId: map['symptom_id']?.toInt() ?? 0,
      description: map['description'] ?? '',
      severity: map['severity']?.toInt() ?? 0,
    );
  }
}
