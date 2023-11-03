import 'package:cc/providers/auth_provider.dart';
import 'package:cc/screens/screens.dart';
import 'package:cc/widgets/progress_indicator.dart';
import 'package:cc/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthProvider authProvider = context.read<AuthProvider>();
    AuthStatus _status = authProvider.status;
    Future.delayed(Duration(seconds: 1), () {
      _status == AuthStatus.uninitialized
          ? {
              showsnackbar(
                context,
                Colors.green,
                _status.toString() + "redirecting to login page",
              ),
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              ),
            }
          : _status == AuthStatus.newuser
              ? {
                  showsnackbar(
                    context,
                    Colors.green,
                    _status.toString() + "redirecting to new user page",
                  ),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewUserForm(),
                    ),
                  ),
                }
              : _status == AuthStatus.authenticated
                  ? {
                      showsnackbar(
                        context,
                        Colors.green,
                        _status.toString() + "redirecting to home page",
                      ),
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      ),
                    }
                  : _status == AuthStatus.authenticateError
                      ? {
                          showsnackbar(
                            context,
                            Colors.green,
                            _status.toString() + "redirecting to error page",
                          ),
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          ),
                        }
                      : {
                          showsnackbar(
                            context,
                            Colors.green,
                            _status.toString() + "redirecting to null page",
                          ),
                        };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              child: SvgPicture.asset(
                "assets/icons/logo.svg",
              ),
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 20),
            Text(
              "Welcome to \n College Connect",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "There is no time like the present to start your college journey,",
              textAlign: TextAlign.center,
            ),
            LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
