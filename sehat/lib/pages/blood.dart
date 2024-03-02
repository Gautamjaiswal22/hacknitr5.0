import 'package:flutter/material.dart';
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

class blood extends StatefulWidget {
  const blood({super.key});

  @override
  State<blood> createState() => _bloodState();
}

class _bloodState extends State<blood> {
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

  String _salutation = "A+";
  final _salutations = [
    "A+",
    "B+",
    "A-",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];
  bool donatedBloodLast6Months = false;
  bool willing = false;
  late String bggroup;
  late String symptoms;

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
                      'Blood Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.all(4),
                  width: double.infinity,
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // You can customize the border color
                      width: 1.0, // You can customize the border width
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // You can customize the border radius
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Enter Blood Group',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButton(
                          // You can customize the dropdown icon
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          // underline: Container(
                          //   height: 2,
                          // ),
                          items: _salutations
                              .map((String item) => DropdownMenuItem<String>(
                                  child: Text(item), value: item))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              print("previous ${this._salutation}");
                              print("selected $value");
                              this._salutation = value!;
                            });
                          },
                          value: _salutation,
                        ),
                      ),
                    ],
                  )),
              //  bool donatedBloodLast6Months = false; // Variable to store whether the user donated blood in the last 6 months
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // You can customize the border color
                    width: 1.0, // You can customize the border width
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // You can customize the border radius
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Are you willing to donate blood ?',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<bool>(
                        value: willing,
                        onChanged: (bool? newValue) {
                          setState(() {
                            willing = newValue ??
                                false; // Update the value of donatedBloodLast6Months
                          });
                        },
                        items: [
                          DropdownMenuItem<bool>(
                            value: true,
                            child: Text('Yes'),
                          ),
                          DropdownMenuItem<bool>(
                            value: false,
                            child: Text('No'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // You can customize the border color
                    width: 1.0, // You can customize the border width
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // You can customize the border radius
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Have you donated blood in the last 6 months?',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<bool>(
                        value: donatedBloodLast6Months,
                        onChanged: (bool? newValue) {
                          setState(() {
                            donatedBloodLast6Months = newValue ??
                                false; // Update the value of donatedBloodLast6Months
                          });
                        },
                        items: [
                          DropdownMenuItem<bool>(
                            value: true,
                            child: Text('Yes'),
                          ),
                          DropdownMenuItem<bool>(
                            value: false,
                            child: Text('No'),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                    // await postman();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE55771),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
