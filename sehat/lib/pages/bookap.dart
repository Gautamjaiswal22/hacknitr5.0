import 'package:ehs/pages/Hospitalsingle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class bookap extends StatefulWidget {
  final String name;
  bookap({required this.name});
  @override
  State<bookap> createState() => _hospitalState();
}

class _hospitalState extends State<bookap> {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  late Map<String, dynamic> hospdetails;
  List<dynamic> hospitals = [];

  Future<void> postData() async {
    // storeLoginDetails(MobileNo);
    final String apiUrl =
        'https://ehs-q3hx.onrender.com/api/fetchhospitals'; // Replace with your API URL

    // Define your request body as a Map or other data structure.

    // Encode the request body as JSON.

    try {
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Successfully posted data
        print('Response data: ${response.body}');
        setState(() {
          hospdetails = json.decode(response.body);
          // print(hospdetails);
          print(hospdetails["status"]);
          hospitals = hospdetails["data"];
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF5F6FB),
        ),
        child: Column(
          children: [
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
                    'Hospitals',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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
                // controller: ageController,
                keyboardType:
                    TextInputType.number, // Set the keyboard type to number
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  labelText: 'Search Hospital', // Updated label text for weight
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(color: Colors.black), // Set input text color
                // Add your validation and onChanged handlers here if needed
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: hospitals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // print(hospdetails);

                        // String hid = hospdetails[index]["hospital_login_cred"]
                        //         ["hid"] ??
                        //     "dummy";
                        // print("hid: $hid");

                        // String hname = hospdetails[index]["general_data"]
                        //         ["hospitalName"] ??
                        //     "demo";
                        String hname = hospitals[index]["general_data"]
                                ["hospitalName"] ??
                            "Unknown Hospital";

                        // Now you can use hname within this loop
                        print("Hospital Name: $hname");

                        String hid = hospitals[index]["hospital_login_cred"]
                                ["hid"] ??
                            "Unknown HID";

                        // Now you can use hid within this loop
                        print("Hospital ID (HID): $hid");

                        // print("hid: $hid");
                        // print("hname: $hname");

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => hospitalsingle(
                            hname: hname,
                            hid: hid,
                            pname: widget.name,
                          ),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(17.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //  image: AssetImage('assets/sahil.jpeg'),
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Image(
                                image: AssetImage(
                                    'assets/hospital.jpg'), // Replace with your image asset path
                                // Set the height of the image
                                width: 287.0,
                                height: 137.0,

                                fit: BoxFit.cover, // Adjust the fit as needed
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start, // Align the row's content to the start (left)
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    hospitals[index]["general_data"]
                                            ["hospitalName"] ??
                                        "Unknown Hospital",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),

                            // Align the row's content to the start (left)

                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                // child: Text(
                                //   'List here',
                                //   textAlign: TextAlign.left,
                                //   style: TextStyle(
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.normal,
                                //   ),
                                // ),
                                //     child: ListView.builder(
                                //   itemCount: items.length,
                                //   itemBuilder: (BuildContext context, int index) {
                                //     return ListTile(
                                //       title: Text(items[index]),
                                //     );
                                //   },
                                // )
                                //
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        hospitals[index]["address_data"]
                                                ["address1"] ??
                                            "demo",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        hospitals[index]["general_data"]
                                                ["type"] ??
                                            "type",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        hospitals[index]["general_data"]
                                                ["ownership"] ??
                                            "ownership",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        hospitals[index]["contact_data"]
                                                ["mobile"] ??
                                            "mobile",
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            // SizedBox(
            //   width: 250,
            //   height: 42.0,
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       await postData();
            //     },
            //     style: ElevatedButton.styleFrom(
            //       primary: Color(0xFFE55771),
            //     ),
            //     child: Text(
            //       'Next',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
