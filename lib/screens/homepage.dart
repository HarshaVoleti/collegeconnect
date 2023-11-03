import 'package:cc/providers/auth_provider.dart';
import 'package:cc/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read<AuthProvider>();
    final profilepic = FirebaseAuth.instance.currentUser!.photoURL!;
    final name = FirebaseAuth.instance.currentUser!.displayName;
    final fakedp =
        "https://firebasestorage.googleapis.com/v0/b/collegeconnect-1461b.appspot.com/o/pp.jpeg?alt=media&token=46f4d886-f111-413f-b1d5-a645a798ed24&_gl=1*wkunm0*_ga*MTIwMjAyNzg3Ni4xNjk3NzE1MDkx*_ga_CW55HF8NVT*MTY5ODk0NjMzNy4yNy4xLjE2OTg5NDYzNTguMzkuMC4w";
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Welcome \n",
                          style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 20.0,
                          ),
                        ),
                        TextSpan(
                          text: name,
                          style: GoogleFonts.lato(
                            color: Colors.purple.withOpacity(0.5),
                            fontStyle: FontStyle.italic,
                            fontSize: 24.0,
                          ),
                        ),
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: profilepic != ""
                                ? NetworkImage(profilepic)
                                : NetworkImage(fakedp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    authProvider.handlelogout(context);
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
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
