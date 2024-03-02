import 'package:ehs/pages/login2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class login1 extends StatefulWidget {
  const login1({Key? key});

  @override
  State<login1> createState() => _login1State();
}

class _login1State extends State<login1> {
  TextEditingController phone = TextEditingController();
  late Map<String, dynamic> logindetails;
  bool enablebtn = true;
  late Map<String, dynamic> olddetails;
  bool button = true;
  Future<void> checkOldUser(var MobileNo) async {
    final String apiUrl =
        'https://ehs-q3hx.onrender.com/api/finduser'; // Replace with your API URL

    // Define your request body as a Map or other data structure.
    Map<String, dynamic> requestBody = {
      "phone": MobileNo,
    };

    // Encode the request body as JSON.
    final String requestBodyJson = jsonEncode(requestBody);
    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBodyJson,
      );

      if (response.statusCode == 200) {
        // Successfully posted data
        print('REGISTRATION Response data: ${response.body}');
        olddetails = json.decode(response.body);
      } else {
        // Handle error responses
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

  Future<void> postData(var MobileNo) async {
    // storeLoginDetails(MobileNo);
    final String apiUrl =
        'https://ehs-q3hx.onrender.com/api/registration'; // Replace with your API URL

    // Define your request body as a Map or other data structure.
    Map<String, dynamic> requestBody = {"phone": "${phone.text}"};
    print(requestBody);
    // Encode the request body as JSON.
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBodyJson,
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        // Successfully posted data
        print('Response data: ${response.body.runtimeType}');
        logindetails = json.decode(response.body);
        print(logindetails);
      } else {
        // Handle error responses
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Wrap your Column inside SingleChildScrollView
        child: Container(
          child: Column(
            children: [
              Container(
                height: 450,
                color: Color(0xFFE55771), // Change the color as needed
                alignment: Alignment
                    .center, // Center the text horizontally and vertically
                child: Text(
                  'SEHAT',
                  style: TextStyle(
                    fontSize: 48, // Adjust the font size as needed
                    fontWeight: FontWeight.bold, // Apply bold font weight
                    color: Colors.white, // Change the text color as needed
                    letterSpacing:
                        2, // Increase letter spacing for better readability
                    // Add more text styles as needed (e.g., fontFamily, fontStyle)
                  ),
                ),
              ),

              // Image(
              //   image: AssetImage('assets/Frame.png'),
              //   height: 450.24,
              //   width: 359.68,
              //   fit: BoxFit.cover,
              // ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 32.0, bottom: 18.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter your Number',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                width: 300,
                child: Card(
                  elevation: 5,
                  child: TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your mobile number',
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 250,
                height: 42.0,
                child: ElevatedButton(
                  onPressed: !button
                      ? null
                      : () async {
                          setState(() {
                            button = false;
                          });
                          await postData(phone.text);
                          print(phone.text);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => login2(
                                  phone: phone.text,
                                  hash: logindetails['hashk'],
                                  otp: logindetails['otp'])));
                          setState(() {
                            button = true;
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE55771),
                  ),
                  child: button
                      ? Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        )
                      : CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
