import 'package:cc/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddSubjectPage extends StatefulWidget {
  const AddSubjectPage({super.key});

  @override
  State<AddSubjectPage> createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  TextEditingController sub_namecontroller = TextEditingController();
  TextEditingController yearcontroller = TextEditingController();
  TextEditingController departmentcontroller = TextEditingController();

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> students = [];
  List<Map<String, String>> filteredStudents = [];
  List<Map<String, String>> selectedStudents = [];

  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final QuerySnapshot snapshot = await studentsCollection.get();
    setState(() {
      students = snapshot.docs
          .map((doc) => {
                'student_id': doc['student_id'] as String,
                'student_name': doc['student_name'] as String,
              })
          .toList();
      filteredStudents = students;
    });
  }

  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredStudents = students;
      } else {
        filteredStudents = students
            .where((student) => student['student_name']!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Subject",
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: sub_namecontroller,
                  onChanged: (value) {
                    setState(() {
                      sub_namecontroller.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    hintText: "Subject Name",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: (size.width / 2) - 30,
                      child: TextFormField(
                        controller: yearcontroller,
                        onChanged: (value) {
                          setState(() {
                            yearcontroller.text = value;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          hintText: "Year",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: (size.width / 2) - 30,
                      child: TextFormField(
                        controller: departmentcontroller,
                        onChanged: (value) {
                          setState(() {
                            departmentcontroller.text = value;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          hintText: "Department",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 400,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Select Students",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      SearchBar(
                        controller: _searchController,
                        onChanged: _filterStudents,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredStudents.length,
                          itemBuilder: (context, index) {
                            final student = filteredStudents[index];
                            final isSelected =
                                selectedStudents.contains(student);
                            return CheckboxListTile(
                              value: isSelected,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selectedStudents.add(student);
                                    showsnackbar(
                                      context,
                                      Colors.green,
                                      '$selectedStudents',
                                    );
                                  } else {
                                    selectedStudents.remove(student);
                                    showsnackbar(
                                      context,
                                      Colors.red,
                                      '$selectedStudents',
                                    );
                                  }
                                });
                              },
                              title: Text(
                                  filteredStudents[index]['student_name']!),
                              // subtitle: Text(
                              //   'Student ID: ${filteredStudents[index]['student_id']}',
                              //   maxLines: 1,
                              // ),
                            );
                          },
                        ),
                      ),
                    ],
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
