import 'dart:io';

import 'package:cc/constants/firebaseconstants.dart';
import 'package:cc/modals/facultyclass.dart';
import 'package:cc/screens/homepage.dart';
import 'package:cc/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirestoreClass();

  Future<String> uploadUserProfilePic(File imageFile, String username) async {
    try {
      final String imageName = '$username-profilepic.jpg';
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('profile_pics/$imageName');

      final UploadTask uploadTask = storageReference.putFile(imageFile);

      final TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

      if (snapshot.state == TaskState.success) {
        final String downloadUrl = await storageReference.getDownloadURL();
        return downloadUrl;
      } else {
        return "https://firebasestorage.googleapis.com/v0/b/collegeconnect-1461b.appspot.com/o/pp.jpeg?alt=media&token=46f4d886-f111-413f-b1d5-a645a798ed24&_gl=1*bg8h1a*_ga*MTIwMjAyNzg3Ni4xNjk3NzE1MDkx*_ga_CW55HF8NVT*MTY5ODk0NjMzNy4yNy4xLjE2OTg5NDYzNjAuMzcuMC4w"; // Failed to upload
      }
    } catch (e) {
      print('Error uploading profile pic: $e');
      return "https://firebasestorage.googleapis.com/v0/b/collegeconnect-1461b.appspot.com/o/pp.jpeg?alt=media&token=46f4d886-f111-413f-b1d5-a645a798ed24&_gl=1*bg8h1a*_ga*MTIwMjAyNzg3Ni4xNjk3NzE1MDkx*_ga_CW55HF8NVT*MTY5ODk0NjMzNy4yNy4xLjE2OTg5NDYzNjAuMzcuMC4w"; // Error occurred
    }
  }

  Future<bool> savenewuserdata(
      {required String username,
      required String photoURL,
      required BuildContext context,
      required String designation,
      required List subjects,
      required String aadhaar,
      required String email}) async {
    try {
      FacultyClass faculty = FacultyClass(
          id: firebaseAuth.currentUser!.uid,
          name: username,
          designation: designation,
          email: email,
          subjects: subjects,
          number: firebaseAuth.currentUser!.phoneNumber!,
          imageURL: photoURL,
          aadhaar: aadhaar);
      firebaseAuth.currentUser!.updateDisplayName(username);
      firebaseAuth.currentUser!.updatePhotoURL(photoURL);

      await firebaseFirestore
          .collection(FirestoreConstants.pathfacultyCollection)
          .doc(firebaseAuth.currentUser!.uid)
          .set(
            faculty.toMap(),
          );
      showsnackbar(
        context,
        Colors.green,
        "uploaded successfully",
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (route) => false);
      return true;
    } catch (e) {
      showsnackbar(
        context,
        Colors.red,
        "error occured $e",
      );
      return false;
    }
  }
}
