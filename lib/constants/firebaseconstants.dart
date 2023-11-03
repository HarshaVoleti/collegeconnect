class FirestoreConstants {
  // Constants for user data
  static const pathfacultyCollection =
      "teacher"; // Assuming "teachers" collection
  static const facultyname = "name"; // Teacher's name
  static const phoneNumber = "phoneNumber"; // Teacher's phone number
  static const designation = "designation"; // Teacher's designation
  static const subjects = [""]; // List of subjects the teacher handles
  static const dateJoined = "dateJoined";
  static const photoURL = "profilepic";
  static const facultyId = "id"; // Teacher's date of joining

  // Constants for attendance data
  static const pathAttendanceCollection =
      "attendance"; // Collection for attendance records
  static const className = "className"; // Class name or identifier
  static const date = "date"; // Date of the attendance record
  static const students = "students"; // List of students' attendance

  // Constants for student data
  static const pathStudentCollection =
      "students"; // Collection for student data
  static const studentName = "name"; // Student's name
  static const rollNumber = "rollNumber"; // Student's roll number
  static const attendanceStatus =
      "attendanceStatus"; // Student's attendance status
}
