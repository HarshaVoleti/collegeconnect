import 'dart:io';

import 'package:cc/providers/firebasefunctions.dart';
import 'package:cc/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class NewUserForm extends StatefulWidget {
  const NewUserForm({super.key});

  @override
  State<NewUserForm> createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController designationcontroller = TextEditingController();
  TextEditingController aadhaarcontroller = TextEditingController();
  List<String> subjects = [];
  CroppedFile? _imageFile;
  String imageURL = "";
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<String> subjectsList = [
      'Mathematics',
      'Physics',
      'Biology',
      'Chemistry',
      'Telugu',
      'Hindi',
      'Sanskrit',
      'English',
      'History',
      'Civics',
      'Geography',
    ];
    Future<void> _pickImage() async {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Crop the selected image
        ImageCropper imageCropper = ImageCropper();

        CroppedFile? croppedFile = await imageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio:
              CropAspectRatio(ratioX: 1, ratioY: 1), // Adjust as needed
          compressQuality: 100, // Adjust image quality as needed
          maxWidth: 512, // Adjust image width as needed
          maxHeight: 512, // Adjust image height as needed
        );

        if (croppedFile != null) {
          setState(() {
            _imageFile = croppedFile;
          });
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Register here",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: _imageFile != null
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.55),
                              image: DecorationImage(
                                image: FileImage(
                                  File(_imageFile!.path),
                                ),
                              ),
                            )
                          : BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.55),
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/dp.png",
                                ),
                              ),
                            ),
                      clipBehavior: Clip.hardEdge,
                      height: 200,
                      width: 200,
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.55),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _pickImage();
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: namecontroller,
                  onChanged: (value) {
                    setState(() {
                      namecontroller.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    hintText: "Name",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailcontroller,
                  onChanged: (value) {
                    setState(() {
                      emailcontroller.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    hintText: "Email Id",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: designationcontroller,
                  onChanged: (value) {
                    setState(() {
                      designationcontroller.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    hintText: "Designation",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: aadhaarcontroller,
                  onChanged: (value) {
                    setState(() {
                      aadhaarcontroller.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    hintText: "Aadhaar Number",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Select your subjects",
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: subjectsList.length,
                      itemBuilder: (context, index) {
                        final subject = subjectsList[index];
                        final isSelected = subjects.contains(subject);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                subjects.remove(subject); // Deselect
                              } else {
                                subjects.add(subject); // Select
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.55)
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(subjectsList[index]),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      showsnackbar(context, Colors.red, "button pressed");
                      try {
                        showsnackbar(
                            context, Colors.green, "initiated process");
                        FirestoreClass firestoreClass = FirestoreClass();
                        if (_imageFile != null) {
                          String _imageURL =
                              await firestoreClass.uploadUserProfilePic(
                                  File(_imageFile!.path), namecontroller.text);
                          showsnackbar(context, Colors.green,
                              "image uploaded $_imageURL");
                          setState(() {
                            imageURL = _imageURL;
                          });
                        } else {
                          setState(() {
                            imageURL = "";
                          });
                        }
                        await firestoreClass.savenewuserdata(
                          username: namecontroller.text,
                          photoURL: imageURL,
                          context: context,
                          designation: designationcontroller.text,
                          subjects: subjects,
                          email: emailcontroller.text,
                          aadhaar: aadhaarcontroller.text,
                        );
                        showsnackbar(
                            context, Colors.green, "data succedully updated");
                      } catch (e) {
                        showsnackbar(context, Colors.red, "error occured $e");
                      }
                    },
                    child: Text(
                      "Register",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
