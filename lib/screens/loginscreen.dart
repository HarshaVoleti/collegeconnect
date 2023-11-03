import 'package:cc/providers/auth_provider.dart';
import 'package:cc/widgets/snackbar.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phonecontroller = TextEditingController();
  Country country = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "IN",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          height: size.height,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Login with your \n",
                    style: Theme.of(context).textTheme.headline4,
                    children: [
                      TextSpan(
                        text: "Phone number ",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                TextFormField(
                  controller: phonecontroller,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      phonecontroller.text == value;
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
                    hintText: "Enter your phone number",
                    prefixIcon: Container(
                      padding: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            countryListTheme: CountryListThemeData(
                              bottomSheetHeight: 550,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onSelect: (country) {
                              setState(() {
                                this.country = country;
                              });
                            },
                          );
                        },
                        child: Text(
                          ' ${country.flagEmoji} + ${country.phoneCode}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: phonecontroller.text.length != 10
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
                  "By continuing you will receive an SMS for verification.",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    AuthProvider authProvider = context.read<AuthProvider>();
                    phonecontroller.text.length == 10
                        ? {
                            authProvider.sendOTP(
                                " +${country.phoneCode}${phonecontroller.text} ",
                                context),
                          }
                        : showsnackbar(
                            context,
                            Colors.red,
                            "Please enter a valid phone number",
                          );
                  },
                  child: Text(
                    "Send OTP",
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
