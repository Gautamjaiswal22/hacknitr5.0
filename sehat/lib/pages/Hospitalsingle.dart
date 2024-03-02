import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class hospitalsingle extends StatefulWidget {
  final String hname;
  final String hid;
  final String pname;
  const hospitalsingle({
    super.key,
    required this.hname,
    required this.hid,
    required this.pname,
  });

  @override
  State<hospitalsingle> createState() => _hospitalsingleState();
}

class _hospitalsingleState extends State<hospitalsingle> {
  late String op;
  Future<String?> getEhsidFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ehsid = prefs.getString('ehsid');
    setState(() {
      op = ehsid!;
    });

    return ehsid;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEhsidFromLocalStorage();
  }

  DateTime selectedDate = DateTime.now();
  String date = "";
  String time = "";
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        time = picked.format(context); // Storing formatted time
      });
    }
  }

  TextEditingController issue = TextEditingController();

  final List<String> items = ['Option 1', 'Option 2', 'Option 3'];
  String selectedItem = 'Option 1';

  Future<void> postData() async {
    // storeLoginDetails(MobileNo);
    print(selectedItem);
    final String apiUrl =
        'https://ehs-q3hx.onrender.com/api/bookAppointment'; // Replace with your API URL

    // Define your request body as a Map or other data structure.
    Map<String, dynamic> requestBody = {
      "patient_data": {"UHID": op, "patient_name": widget.pname},
      "appointment_data": {
        "date": date,
        "hospital_id": widget.hid,
        "doctor_id": "dumy",
        "health_issue": selectedItem
      },
      "transaction_data": {
        "booked_on": date,
        "transaction_id": "TRA12354",
        "amount": 250
      },
      "diagnosis_data": {"status": "registered"}
    };
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F6FB),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 100.0,
              ),
              Container(
                alignment: Alignment.center, // Aligns child to the center
                child: Text(
                  widget.hname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18, // Sets the font size to 18 pixels
                    fontWeight: FontWeight.bold, // Makes the text bold
                  ), // Aligns text within the Text widget to the center
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              // Text(widget.pname),
              // Text(op),
              // Text(widget.hname),
              // Text(widget.pname),
              // Text(widget.hid),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the border radius as needed
                  child: Image(
                    image: AssetImage(
                        'assets/hospital.jpg'), // Replace with your image asset path
                    width: 287.0,
                    height: 137.0,
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color to white
                ),
                width: 287.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the border radius as needed
                  child: Column(
                    children: [
                      Text(
                        'Appointment Booking Charge',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18, // Sets the font size to 18 pixels
                          fontWeight: FontWeight.normal, // Makes the text bold
                        ), // Aligns text within the Text widget to the center
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '₹100/-',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18, // Sets the font size to 18 pixels
                          fontWeight: FontWeight.normal, // Makes the text bold
                        ), // Aligns text within the Text widget to the center
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('pick health issue'),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        child: Card(
                          elevation: 5,
                          child: Center(
                            child: DropdownButton<String>(
                              value: selectedItem,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedItem = newValue;
                                    print(selectedItem);
                                  });
                                }
                              },
                              items: items.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Choose Time'),
                      SizedBox(
                        width: 20,
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("$time"),
                            ElevatedButton(
                              onPressed: () => _selectTime(context),
                              child: const Text('Select time'),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFE55771),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                width: 151.0,
                height: 39.0,
                child: ElevatedButton(
                  onPressed: () async {
                    await postData();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE55771),
                  ),
                  child: Text(
                    'Book',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
