class Subject {
  final String sub_id;
  final String sub_name;
  final String faculty_name;
  final String faculty_id;
  final List students;

  Subject({
    required this.sub_id,
    required this.sub_name,
    required this.faculty_id,
    required this.faculty_name,
    required this.students,
  });

  Map<String, dynamic> toMap() {
    return {
      'sub_id': sub_id,
      'sub_name': sub_name,
      'faculty_name': faculty_name,
      'faculty_id': faculty_id,
      'students': students,
    };
  }
}
