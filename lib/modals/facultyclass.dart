import 'package:flutter/material.dart';

class FacultyClass {
  final String id;
  final String name;
  final String designation;
  final String email;
  final List subjects;
  final String aadhaar;
  final String imageURL;
  final String number;

  FacultyClass({
    required this.id,
    required this.name,
    required this.designation,
    required this.email,
    required this.subjects,
    required this.number,
    required this.aadhaar,
    required this.imageURL,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'email': email,
      'subjects': subjects,
      'aadhaar': aadhaar,
      'imageURL': imageURL,
    };
  }
}

class FacultyClassProvider extends ChangeNotifier {
  FacultyClass? _user;
  FacultyClass get user => _user!;
  void setUser(FacultyClass user) {
    _user = user;
    notifyListeners();
  }
}
