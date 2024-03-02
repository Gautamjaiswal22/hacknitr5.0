import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

void main() => runApp(UserAuth());

class UserAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FingerprintAuthenticationScreen(),
    );
  }
}

class FingerprintAuthenticationScreen extends StatefulWidget {
  @override
  _FingerprintAuthenticationScreenState createState() =>
      _FingerprintAuthenticationScreenState();
}

class _FingerprintAuthenticationScreenState
    extends State<FingerprintAuthenticationScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType> _availableBiometric = [];
  String _authorized = '';

  Future<void> _getAvailableBiometric() async {
    try {
      _availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      if (_availableBiometric.contains(BiometricType.fingerprint)) {
        authenticated = await auth.authenticate(
          localizedReason: "Scan your fingerprint to authenticate",
          // useErrorDialogs: true,
          // stickyAuth: true,
        );
      } else if (_availableBiometric.contains(BiometricType.face)) {
        authenticated = await auth.authenticate(
          localizedReason: "Scan your face to authenticate",
          // useErrorDialogs: true,
          // stickyAuth: true,
        );
      } else {
        print("No compatible biometric methods available.");
      }
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      _authorized =
          authenticated ? "Authorized successfully" : "Failed to authenticate";
      print(_authorized);
    });
  }

  @override
  void initState() {
    _getAvailableBiometric();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade600,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: const Text(
                      "Authenticate using your fingerprint instead of your password",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, height: 1.5),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    width: double.infinity,
                    child: FloatingActionButton(
                      onPressed: _authenticate,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 14.0),
                        child: Text(
                          "Authenticate",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
