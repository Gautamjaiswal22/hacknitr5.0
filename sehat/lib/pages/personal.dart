import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class personal extends StatefulWidget {
  // Define the TextEditingController as a class member
  static TextEditingController ageController = TextEditingController();
  static TextEditingController heightController = TextEditingController();
  static TextEditingController weightController = TextEditingController();
  static TextEditingController bpController = TextEditingController();
  static TextEditingController sugerController = TextEditingController();

  @override
  State<personal> createState() => _personalState();
}

class _personalState extends State<personal> {
  int age = 0;
  int height = 0;
  int weight = 0;
  int bp = 0;
  int suger = 0;
  void submitForm() {
    age = int.tryParse(personal.ageController.text) ?? 0;
    height = int.tryParse(personal.heightController.text) ?? 0;
    weight = int.tryParse(personal.weightController.text) ?? 0;
    bp = int.tryParse(personal.bpController.text) ?? 0;
    suger = int.tryParse(personal.sugerController.text) ?? 0;
    // Process the form data (e.g., send it to an API, perform validation, etc.)
    // Print the form data for demonstration
    print('Age: $age');
    print('Height: $height cm');
    print('Weight: $weight kg');
    postData();
  }

  late String op;

  Future<String?> getEhsidFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ehsid = prefs.getString('ehsid');
    setState(() {
      op = ehsid!;
    });

    return ehsid;
  }

  Future<void> postData() async {
    // storeLoginDetails(MobileNo);

    final String apiUrl =
        'https://ehs-q3hx.onrender.com/api/gendata/${op}'; // Replace with your API URL

    // Define your request body as a Map or other data structure.
    Map<String, dynamic> requestBodyuser = {
      "age": age,
      "height": height,
      "weight": weight,
      "bp": bp,
      "sugar": suger,
    };
    print(requestBodyuser);
    // Encode the request body as JSON.
    final String requestBodyJson = jsonEncode(requestBodyuser);

    try {
      final http.Response response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBodyJson,
      );
      print(response.body);
      if (response.statusCode == 200) {
        print("data sent succefully");
      } else {
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getEhsidFromLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F6FB),
          ),
          child: Column(children: [
            SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30.0,
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 1.0),
                  child: Text(
                    'General Data',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .start, // Align the row's content to the start (left)
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 28.0),
                  child: Text(
                    'your age',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 45.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                controller: personal.ageController,
                keyboardType:
                    TextInputType.number, // Set the keyboard type to number
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  labelText: 'Enter your age', // Updated label text for weight
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(color: Colors.black), // Set input text color
                // Add your validation and onChanged handlers here if needed
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .start, // Align the row's content to the start (left)
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 28.0),
                  child: Text(
                    'Your Height (in cm)',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 45.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                controller: personal.heightController,
                keyboardType:
                    TextInputType.number, // Set the keyboard type to number
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  labelText: 'Enter your height (in cm)', // Updated label text
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(color: Colors.black), // Set input text color
                // Add your validation and onChanged handlers here if needed
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .start, // Align the row's content to the start (left)
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 28.0),
                  child: Text(
                    ' weight (in kg)',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 45.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                controller: personal.weightController,
                keyboardType:
                    TextInputType.number, // Set the keyboard type to number
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  labelText:
                      'Enter your weight (in kg)', // Updated label text for weight
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(color: Colors.black), // Set input text color
                // Add your validation and onChanged handlers here if needed
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .start, // Align the row's content to the start (left)
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 28.0),
                  child: Text(
                    ' Blood Pressure',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 45.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                controller: personal.bpController,
                keyboardType:
                    TextInputType.number, // Set the keyboard type to number
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  labelText:
                      'Enter your Blood pressure', // Updated label text for weight
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(color: Colors.black), // Set input text color
                // Add your validation and onChanged handlers here if needed
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .start, // Align the row's content to the start (left)
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 28.0),
                  child: Text(
                    ' Suger levels',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 45.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                controller: personal.sugerController,
                keyboardType:
                    TextInputType.number, // Set the keyboard type to number
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  labelText:
                      'Enter your weight suger levels', // Updated label text for weight
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(color: Colors.black), // Set input text color
                // Add your validation and onChanged handlers here if needed
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                submitForm(); // Call the submitForm method here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFFE55771), // Replace this with your desired color
              ),
              child: Text('Submit'),
            ),
            SizedBox(
              height: 30.0,
            ),
          ]),
        ),
      ),
    );
  }
}
