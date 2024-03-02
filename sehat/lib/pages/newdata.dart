// import 'dart:html';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'dart:async';

class newdata extends StatefulWidget {
  @override
  State<newdata> createState() => _newdataState();
}

class _newdataState extends State<newdata> {
  late String op;
  Future<String?> getEhsidFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ehsid = prefs.getString('ehsid');
    setState(() {
      op = ehsid!;
      print("Ehs id :  $op");
    });

    return ehsid;
  }

  // var url = Uri.parse('https://ehs-q3hx.onrender.com/api/addReport/${op}');
  late PlatformFile file;
  late var filebyte;
  late String selectedFileName =
      "upload your prescription here"; // Changed to nullable

  Future<void> _selectFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = result.files.first;
      filebyte = result.files.first.bytes;

      setState(() {
        selectedFileName = file.name; // Update the selected file name
      });
      print('Selected file: ${file.name}');
      // Get the file as bytes
      // List<int> fileBytes = file.bytes ?? [];

      // // Convert List<int> to Uint8List
      // Uint8List uint8list = Uint8List.fromList(fileBytes);

      // // Create a File object from Uint8List
      // late File selectedFile = File.fromRawPath(uint8list);
      // You can handle the selected file here, such as uploading it to a server.
    } else {
      print('File selection canceled.');
    }
  }

  DateTime selectedDate = DateTime.now();
  String date = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    date = DateFormat.yMMMMd().format(selectedDate);
    print('Selected date: $date');
  }

  late String title = "disease";
  late String symptoms = "Symptoms";

// late Map<String, dynamic> historydata = {
//   "title":title,
//   "fileURL":pdf,
//   "date":date,
//   "Symptoms":symptoms,

// };
  Map<String, dynamic> convertPlatformFileToMap(PlatformFile file) {
    return {
      'path': file.path,
      'name': file.name,
      'size': file.size,
      // Add other properties you need
    };
  }

  Future<void> postman() async {
    Map<String, dynamic> fileAsMap = convertPlatformFileToMap(file);
    var Historyfile = fileAsMap['path'];
    // Historyfile.remove('pdf');
    // String updatedString = Historyfile.substring(6);
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://ehs-q3hx.onrender.com/api/addReport/${op}'));
    request.fields.addAll({'title': title, 'date': date, 'symptoms': symptoms});
    request.files.add(await http.MultipartFile.fromPath('pdf', Historyfile));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.stream);

      var result = await response.stream.bytesToString();
      print(result);
      print("hue");
      await Future.delayed(Duration(seconds: 1));
      print(result.substring(11, result.length - 1));
      bool isSuccess = result.substring(11, result.length - 1) == "true";
      print(isSuccess);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: isSuccess
                ? Text(
                    'Report Uploaded',
                    style: TextStyle(color: Colors.green),
                  )
                : Text(
                    "Rende",
                    style: TextStyle(color: Colors.red),
                  ),
            content: Text(isSuccess
                ? 'Your Report has been uploaded'
                : 'Error in Uploading file'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      print(response.reasonPhrase);
    }
    // Simulating a delay of 2 seconds

    // Show Appointment Booked dialog after postData function execution
  }

  Future<void> postData() async {
    // storeLoginDetails(MobileNo);
    Map<String, dynamic> fileAsMap = convertPlatformFileToMap(file);
    var Historyfile = fileAsMap['path'];
    // Historyfile.remove('pdf');
    String updatedString =
        Historyfile.substring(6); // Start from index 5 to exclude 'pdf: '

    final String apiUrl =
        'https://ehs-q3hx.onrender.com/api/addReport/${op}'; // Replace with your API URL

    // Define your request body as a Map or other data structure.
    late Map<String, dynamic> historydata = {
      "title": title,
      // "pdf": file,
      "pdf": updatedString,

      "date": date,
      "symptoms": symptoms,
    };
    print(historydata);
    // Encode the request body as JSON.
    final String requestBodyJson = jsonEncode(historydata);

    try {
      final http.Response response = await http.post(
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

    await Future.delayed(
        Duration(seconds: 1)); // Simulating a delay of 2 seconds

    // Show Appointment Booked dialog after postData function execution
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Booked'),
          content: Text('Your appointment has been successfully booked.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
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
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 38,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Text(
                      'New Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      // spreadRadius: 5, // Spread radius
                      // blurRadius: 7, // Blur radius
                      // offset: Offset(0, 3), // Offset for the shadow
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: 'Enter Disease',
                    labelStyle: TextStyle(
                        fontSize: 18), // Set the font size of the label text
                    hintText: 'Enter Disease',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text) {
                    // Handle the text input
                    print('Input: $text');
                    title = text;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      // spreadRadius: 5, // Spread radius
                      // blurRadius: 7, // Blur radius
                      // offset: Offset(0, 3), // Offset for the shadow
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: 'add symptoms',
                    labelStyle: TextStyle(
                        fontSize: 18), // Set the font size of the label text
                    hintText: 'enter all the visible symptoms',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text) {
                    // Handle the text input
                    print('Input: $text');
                    symptoms = text;
                  },
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _selectFile(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    height: 100.0,
                    width: double.infinity,
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.black, // Set border color here
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        selectedFileName, // Display selected file name here
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor:
              //         Color(0xFFE55771), // Replace this with your desired color
              //   ),
              //   onPressed: _selectFile,
              //   child: Text('Upload File'),
              // ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Choose Date'),
                      SizedBox(
                        width: 20,
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("${selectedDate.toLocal()}".split(' ')[0]),
                            // const SizedBox(
                            //   height: 20.0,
                            // ),
                            ElevatedButton(
                              onPressed: () => _selectDate(context),
                              child: const Text('Select date'),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFE55771),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 151.0,
                height: 39.0,
                child: ElevatedButton(
                  onPressed: () async {
                    // await postData();
                    await postman();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE55771),
                  ),
                  child: Text(
                    'Add health histoy',
                    style: TextStyle(color: Colors.white),
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
