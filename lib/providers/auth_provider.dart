// ignore_for_file: prefer_function_declarations_over_variables
import 'package:cc/constants/firebaseconstants.dart';
import 'package:cc/screens/screens.dart';
import 'package:cc/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  landing,
  uninitialized,
  otpsent,
  newuser,
  verifyingOTP,
  loading,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanelled,
}

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  // final SharedPreferences prefs;

  AuthProvider({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    // required this.prefs,
  });
  bool isloggedin = FirebaseAuth.instance.currentUser != null ? true : false;

  AuthStatus _status = FirebaseAuth.instance.currentUser != null
      ? AuthStatus.authenticated
      : AuthStatus.uninitialized;

  AuthStatus get status => _status;

  Future<bool> sendOTP(String phoneNumber, BuildContext context) async {
    _status = AuthStatus.authenticating;
    showsnackbar(
      context,
      Colors.green,
      "1, occured a" + _status.toString(),
    );
    notifyListeners();
    try {
      // ignore: unused_local_variable
      final PhoneVerificationCompleted verificationCompleted =
          (PhoneAuthCredential authCredential) async {
        // if (firebaseUser != null) {
        //   final QuerySnapshot result = await firebaseFirestore
        //       .collection(FirestoreConstants.pathUserCollection)
        //       .where(FirestoreConstants.facultyId, isEqualTo: firebaseUser.uid)
        //       .get();
        //   final List<DocumentSnapshot> documents = result.docs;
        //   if (documents.length == 0) {
        //     _status = AuthStatus.newuser;
        //     showsnackbar(
        //       context,
        //       Colors.green,
        //       "1.2, occured" + _status.toString(),
        //     );
        //     notifyListeners();
        //   } else {
        //     DocumentSnapshot documentSnapshot = documents[0];
        // await prefs.setString(
        //   FirestoreConstants.facultyId,
        //   documentSnapshot.id,
        // );
        // await prefs.setString(
        //   FirestoreConstants.facultyname,
        //   firebaseUser.displayName ??
        //       documentSnapshot[FirestoreConstants.facultyname],
        // );
        // await prefs.setString(
        //   FirestoreConstants.photoURL,
        //   firebaseUser.photoURL ??
        //       documentSnapshot[FirestoreConstants.photoURL],
        // );
        // await prefs.setString(
        //   FirestoreConstants.phoneNumber,
        //   firebaseUser.phoneNumber ??
        //       documentSnapshot[FirestoreConstants.phoneNumber],
        // );
        // await prefs.setString(
        //   FirestoreConstants.designation,
        //   documentSnapshot[FirestoreConstants.designation] ?? "",
        // );
        // _status = AuthStatus.authenticated;
        // showsnackbar(
        //   context,
        //   Colors.green,
        //   "3, occured" + _status.toString(),
        // );
        // notifyListeners();
        // }
        // } else {
        //   _status = AuthStatus.authenticateError;
        //   showsnackbar(
        //     context,
        //     Colors.green,
        //     _status.toString() + "is occured",
        //   );
        //   notifyListeners();
        // }
      };
      final PhoneVerificationFailed verificationFailed =
          (FirebaseAuthException authException) {
        _status = AuthStatus.authenticateError;
        showsnackbar(
          context,
          Colors.green,
          "5, occured" + _status.toString() + authException.message!,
        );
        notifyListeners();
      };
      final PhoneCodeSent codeSent =
          (String verificationId, [int? forceResendingToken]) {
        showsnackbar(
          context,
          Colors.green,
          "otp was sent",
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              verificationId: verificationId,
              number: phoneNumber,
            ),
          ),
        );
        showsnackbar(
          context,
          Colors.green,
          "navigated to otp screen",
        );
      };
      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
        // Handle the case when auto-retrieval times out and code is not detected.
      };
      showsnackbar(
        context,
        Colors.green,
        "initiated",
      );
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );

      return true;
    } catch (e) {
      _status = AuthStatus.authenticateError;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOTPAndLogin(
      String verificationId, String smsCode, BuildContext context) async {
    _status = AuthStatus.verifyingOTP;
    showsnackbar(
      context,
      Colors.green,
      "2.1, " + _status.toString() + "is occured",
    );
    notifyListeners();

    try {
      showsnackbar(
        context,
        Colors.green,
        "2.2, " + _status.toString() + "is initiated",
      );
      PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      showsnackbar(
        context,
        Colors.green,
        "6, auth credentials are occured " + authCredential.toString(),
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(authCredential);
      showsnackbar(
        context,
        Colors.green,
        "7, signin with " + userCredential.toString(),
      );
      User firebaseUser = userCredential.user!;
      showsnackbar(
        context,
        Colors.green,
        "6, signin with " + "is initiated",
      );

      // ignore: unnecessary_null_comparison
      if (firebaseUser != null) {
        // Check if the user exists in the Firestore database
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreConstants.pathfacultyCollection)
            .where(FirestoreConstants.facultyId, isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;

        if (documents.length == 0) {
          _status = AuthStatus.newuser;
          showsnackbar(
            context,
            Colors.green,
            "2.6, occured new user" + _status.toString(),
          );

          notifyListeners();
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NewUserForm(),
            ),
          );
        } else {
          _status = AuthStatus.authenticated;
          showsnackbar(
            context,
            Colors.green,
            "2.5, occured existing user" + _status.toString(),
          );
          notifyListeners();
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );

          // Handle any data you need from the document
        }

        return true;
      } else {
        _status = AuthStatus.authenticateError;
        showsnackbar(
          context,
          Colors.green,
          "3, " + _status.toString() + "is initiated",
        );
        notifyListeners();
        return false;
      }
    } catch (e) {
      _status = AuthStatus.authenticateError;
      showsnackbar(
        context,
        Colors.green,
        "4, " + _status.toString() + "is initiated" + e.toString(),
      );
      notifyListeners();
      return false;
    }
  }

  Future<bool> handlelogout(BuildContext context) async {
    try {
      FirebaseAuth.instance.signOut();
      _status = AuthStatus.uninitialized;
      showsnackbar(
        context,
        Colors.green,
        "logged out",
      );
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
          (route) => false);
      return true;
    } catch (e) {
      showsnackbar(
        context,
        Colors.red,
        "error occured ${e}",
      );
      return false;
    }
  }
}
