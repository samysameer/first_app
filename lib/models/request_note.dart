class RequestNote {
  final int noteNo;
  final String noteText;
  final DateTime createdAt;

  RequestNote({
    required this.noteNo,
    required this.noteText,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'note_no': noteNo,
      'note_text': noteText,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory RequestNote.fromMap(Map<String, dynamic> map) {
    return RequestNote(
      noteNo: map['note_no']?.toInt() ?? 0,
      noteText: map['note_text'] ?? '',
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
    );
  }
}
