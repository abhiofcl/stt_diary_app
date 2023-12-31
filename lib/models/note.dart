// ignore_for_file: public_member_api_docs, sort_constructors_first
class Note {
  final int id;
  final String date;
  final String time;
  final String? note;
  final String createdAt;
  final String? updatedAt;
  Note({
    required this.id,
    required this.date,
    required this.time,
    required this.createdAt,
    this.updatedAt,
    this.note,
  });
}
