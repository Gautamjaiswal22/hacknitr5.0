import 'package:sehat/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class login3 extends StatefulWidget {
  final String phone;
  const login3({Key? key, required this.phone});

  @override
  State<login3> createState() => _login3State();
}

class _login3State extends State<login3> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  bool button = true;
  late Map<String, dynamic> logindetails;
  Future<void> postData() async {
    // storeLoginDetails(MobileNo);
    final String apiUrl =
        'https://ehs-q3hx.onrender.com/api/addname'; // Replace with your API URL

    // Define your request body as a Map or other data structure.
    Map<String, dynamic> requestBody = {
      "phone": widget.phone,
      "name": name.text,
      "city": city.text,
      "mail": email.text,
    };
    print(requestBody);
    // Encode the request body as JSON.
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final http.Response response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBodyJson,
      );

      if (response.statusCode == 200) {
        // Successfully posted data
        print('Response data: ${response.body.runtimeType}');
        setState(() {
          logindetails = json.decode(response.body);
          print(logindetails);
        });
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

  void savetopreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("name", name.text);
    prefs.setString("mail", email.text);
    prefs.setString("phone", widget.phone);
    prefs.setBool("isloggedin", true);
    print('login status saved to local storage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/Framesecond.png'),
                height: 179.71,
                width: 359.68,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 100.0,
              ),
              Container(
                child: Text(
                  'Signup on EHS',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  'make sure you enter valid details',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                width: 300,
                child: Card(
                  elevation: 5,
                  child: TextFormField(
                    controller: name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Full Name',
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: 300,
                child: Card(
                  elevation: 5,
                  child: TextFormField(
                    controller: email,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email address',
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: 300,
                child: Card(
                  elevation: 5,
                  child: TextFormField(
                    controller: city,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'City',
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
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
                          await postData();
                          savetopreference();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                          setState(() {
                            button = true;
                          });
                        },
                  style: ElevatedButton.styleFrom(
                      // primary: Color(0xFFE55771),
                      ),
                  child: button
                      ? Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        )
                      : CircularProgressIndicator(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Terms and cinnditions related to'),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Details',
                        style: TextStyle(
                          color: Colors.blue, // Set text color to blue
                          decoration: TextDecoration
                              .underline, // Add underline decoration
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
