import 'package:cc/constants/firebaseconstants.dart';
import 'package:cc/screens/addsubjectscreen.dart';
import 'package:cc/widgets/progress_indicator.dart';
import 'package:cc/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userData = {};
  bool isLoading = true;
  String name = FirebaseAuth.instance.currentUser!.displayName!;

  String email = "email";
  String number = FirebaseAuth.instance.currentUser!.phoneNumber!;
  String aadhaar = "aadhaar";
  String designation = "designation";
  String photourl = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserData();
  }

  Future<void> getuserData() async {
    CollectionReference facultycollection = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathfacultyCollection);

    try {
      // Fetch user data based on the user's unique identifier
      DocumentSnapshot userDocument =
          await facultycollection.doc(widget.uid).get();

      // Check if the document exists and contains data
      if (userDocument.exists) {
        setState(() {
          userData = userDocument.data() as Map<String, dynamic>;
          name = "${userData['name']}";
          email = "${userData['email']}";
          photourl = "${userData['imageURL']}";
          aadhaar = "${userData['aadhaar']}";
          designation = "${userData['designation']}";
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle any errors or exceptions that may occur during data retrieval
      showsnackbar(context, Colors.red, "error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final profilepic = FirebaseAuth.instance.currentUser!.photoURL!;
    return Scaffold(
      body: isLoading
          ? Center(
              child: LoadingIndicator(),
            )
          : SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(profilepic),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(name),
                      Text(email),
                      Text(aadhaar),
                      Text(designation),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subjects",
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddSubjectPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Add subject",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
