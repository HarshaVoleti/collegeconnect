import 'package:cc/providers/auth_provider.dart';
import 'package:cc/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final verificationId;
  final number;
  const OTPScreen({
    super.key,
    required this.verificationId,
    required this.number,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "OTP Verification",
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter the OTP sent to ${widget.number}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: otpcontroller,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      otpcontroller.text == value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter OTP",
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
                    suffixIcon: otpcontroller.text.length != 6
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.check_circle,
                            size: 25,
                            color: Colors.green,
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Didn't receive the OTP? ",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  "Resend OTP",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    AuthProvider authProvider = context.read<AuthProvider>();
                    otpcontroller.text.length == 6
                        ? authProvider.verifyOTPAndLogin(
                            widget.verificationId, otpcontroller.text, context)
                        : showsnackbar(
                            context,
                            Colors.red,
                            "Please enter a valid phone number",
                          );
                  },
                  child: Text("Verify"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
