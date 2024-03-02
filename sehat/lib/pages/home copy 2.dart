import 'dart:ffi';

import 'package:ehs/pages/bookap.dart';
import 'package:ehs/pages/campdetailed.dart';
import 'package:ehs/pages/doctordetailed.dart';
import 'package:ehs/pages/generaldet.dart';
import 'package:ehs/pages/hospital.dart';
import 'package:ehs/pages/login1.dart';
import 'package:ehs/pages/newdata.dart';
import 'package:ehs/pages/prescription.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ehs/pages/prescrib.dart';
import 'package:ehs/pages/uprofile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ehs/pages/blood.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _queryController = TextEditingController();
  late String? name;
  late String? mail;
  late String? number;
  Future<void> getuserdetailsFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString("name");
    mail = prefs.getString("mail");
    number = prefs.getString("phone");
  }

  void _handleSubmitted(String text) {
    print('Entered query: $text');
  }

  @override
  Widget build(BuildContext context) {
    return appBar();
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

  List<String> boxData = [
    'Box 1',
    'Box 2',
    'Box 3',
    'Box 4',
    'Box 5', /* Add more items */
  ];
  List<String> docs = [
    'Doc 1',
    'Doc 2',
    'Doc 3',
    'Doc 4',
    'Doc 5', /* Add more items */
  ];
  List<Color> boxColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple
  ];
  late Map<String, dynamic> campdetails;

  List<dynamic> camps = [];
  late Map<String, dynamic> docdetails;

  List<dynamic> doctors = [];

  Future<void> postData() async {
    // storeLoginDetails(MobileNo);
    final String apiUrl =
        'https://ehs-q3hx.onrender.com/api/getCamps'; // Replace with your API URL

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
        // Successfully pos sted data
        print('Response data: ${response.body.runtimeType}');
        setState(() {
          // campdetails = json.decode(response.body);
          // // print(hospdetails);
          // print(campdetails["status"]);
          // camps = campdetails["data"];
          camps = json.decode(response.body);

          // print(camps.runtimeType);
          // print(camps);
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

  Future<void> postDataDoc() async {
    // storeLoginDetails(MobileNo);
    final String apiUrl =
        'https://ehs-q3hx.onrender.com/api/fetchDR/653ed82877abbcd6e6d1c4c6'; // Replace with your API URL

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
        // Successfully pos sted data
        print('Response data: ${response.body.runtimeType}');
        setState(() {
          // campdetails = json.decode(response.body);
          // // print(hospdetails);
          // print(campdetails["status"]);
          // camps = campdetails["data"];
          doctors = json.decode(response.body);
          print(doctors.runtimeType);
          print(doctors);
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
    postDataDoc();
    getEhsidFromLocalStorage();
    getuserdetailsFromLocalStorage();
  }

  Scaffold appBar() {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.menu), // Drawer icon
        //   onPressed: () {
        //     Scaffold.of(context).openDrawer(); // Opens the drawer
        //   },
        // ),
        iconTheme: IconThemeData(color: Color(0xFFE55771)),
        toolbarHeight: 60.0,
        elevation: 2,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            // Container(
            //     margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
            //     child: Row(
            //       children: [
            //         Expanded(
            //           child: Container(
            //             margin: EdgeInsets.only(right: 20.0),
            //             decoration: BoxDecoration(boxShadow: [
            //               BoxShadow(
            //                 color: Color(0xff1D1617).withOpacity(0.40),
            //                 blurRadius: 10,
            //                 spreadRadius: 0.0,
            //               )
            //             ]),
            //             // height: 35.0,

            //             // child: Expanded(
            //             child: TextField(
            //                 controller: _queryController,
            //                 onSubmitted: _handleSubmitted,
            //                 decoration: InputDecoration(
            //                   hintText: 'Enter your query',
            //                   alignLabelWithHint: true,
            //                   filled: true,
            //                   fillColor: Colors.white,
            //                   prefixIcon: Icon(Icons.search),
            //                   // contentPadding: EdgeInsets.all(20),
            //                   border: OutlineInputBorder(
            //                     borderRadius: BorderRadius.circular(5),
            //                     borderSide: BorderSide.none,
            //                   ),
            //                 )),
            //           ),
            //           // ),
            //         ),
            //         Container(
            //             decoration: BoxDecoration(
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Color(0xff1D1617).withOpacity(0.40),
            //                   blurRadius: 1,
            //                   spreadRadius: -2.0,
            //                 )
            //               ],
            //               borderRadius: BorderRadius.circular(20.0),
            //             ),
            //             margin: EdgeInsets.only(left: 10.0, right: 0.0),
            //             child: Container(
            //               height: 40.0,
            //               width: 40.0,
            //               child: IconButton(
            //                   onPressed: () {
            //                     Navigator.of(context).push(MaterialPageRoute(
            //                         builder: (context1) => uprof()));
            //                   },
            //                   icon: Icon(Icons.person)),
            //             )),
            //       ],
            //     )),
            // SizedBox(
            //   height: 20,
            // ),
            Row(
              children: [
                Expanded(
                  flex: 12, // Adjust the flex value to control TextField width
                  child: Container(
                    height: 35,
                    child: TextField(
                      controller: _queryController,
                      onSubmitted: _handleSubmitted,
                      decoration: InputDecoration(
                        hintText: 'Enter your query',
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                // Expanded(
                //   flex: 2, // Adjust the flex value to control icon width
                //   child: Align(
                //     alignment: Alignment.centerRight,
                //     child: GestureDetector(
                //       onTap: () {
                //         // Perform the desired action when the person icon is tapped
                //         Navigator.of(context).push(
                //           MaterialPageRoute(builder: (context1) => uprof()),
                //         );
                //         print('Person icon tapped!');
                //       },
                //       child: Padding(
                //         padding: const EdgeInsets.all(2.0),
                //         child: CircleAvatar(
                //           backgroundColor: Colors.grey,
                //           child: Icon(Icons.person, color: Colors.white),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )
          ],
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.menu), // Drawer icon
        //   onPressed: () {
        //     Scaffold.of(context).openDrawer(); // Opens the drawer
        //   },
        // ),
        actions: [
          IconButton(
            icon: Icon(Icons.person), // User profile icon
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context1) => uprof()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: buildBody(),
      ),
      drawer: Drawer(
        child: Container(
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Set the color of the bottom border
                    width: 1.5, // Set the width of the bottom border
                  ),
                ),
              ),
              child: Row(children: [
                Container(
                  margin: EdgeInsets.only(left: 0, top: 60),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/sahil.jpeg'),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 60), // Set the top margin value as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name!,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'ID: ${op}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          mail!,
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Align children to the start (left)
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Profile',
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 70,
                  padding: EdgeInsets.only(left: 10.0, top: 14.0),
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GeneralDet(
                                      name: name!,
                                    )),
                          );
                        },
                        child: Text('Edit Profile'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Add Adhar')
                    ],
                  ),
                )
              ],
            )),
            SizedBox(
              height: 40.0,
            ),
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Align children to the start (left)
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Preferences',
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 100,
                  padding: EdgeInsets.only(left: 10.0, top: 14.0),
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Change language'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Notifications'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Data Sharing'),
                      SizedBox(height: 5),
                    ],
                  ),
                )
              ],
            )),
            SizedBox(
              height: 25,
            ),
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Align children to the start (left)
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Security',
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.only(left: 10.0, top: 14.0),
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  child: Column(
                    children: [
                      Text('Enable Biometric'),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            )),
            SizedBox(
              height: 14,
            ),
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Align children to the start (left)
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.only(left: 10.0, top: 14.0),
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  child: Column(
                    children: [
                      Text('About EHS'),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            )),
            SizedBox(
              height: 0,
            ),
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Align children to the start (left)
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.only(left: 10.0, top: 14.0),
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => login1()),
                          );
                        },
                        child: Text('Logout'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            )),
          ]),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150.0,
              margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                color: Color(0xFFE55771),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0), // Adjust the radius as needed
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 20.0,
                      left: 16.0,
                      bottom: 5.0,
                    ),
                    margin: EdgeInsets.only(
                      top: 1.0,
                    ),
                    decoration: BoxDecoration(
                        // color: Color(0xFFE55771),
                        ),
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 1.0, left: 16.0),
                    child: Text(
                      'update your information \n to get insights',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.transparent,
                      border: Border.all(
                        color: Color.fromRGBO(239, 116, 138, 1),
                      ),
                    ),
                    child: LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(239, 116, 138, 1),
                      value: 0.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            // Add more children here, for example:
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  // First Box
                  // GeneralDet

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => prescrib(
                                    name: name!,
                                  )),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        height: 70.0,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius as needed
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Shadow color
                              offset: Offset(0, 3), // Offset of the shadow
                              blurRadius: 5.0, // Blur radius
                              spreadRadius: 0.0, // Spread radius
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Health History',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Second Box
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => bookap(
                                    name: name!,
                                  )),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        height: 70.0,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius as needed
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Shadow color
                              offset: Offset(0, 3), // Offset of the shadow
                              blurRadius: 5.0, // Blur radius
                              spreadRadius: 0.0, // Spread radius
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Book Appointment',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Third Box
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => hospital(
                                    name: name!,
                                  )),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        height: 70.0,
                        margin: EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius as needed
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Shadow color
                              offset: Offset(0, 3), // Offset of the shadow
                              blurRadius: 5.0, // Blur radius
                              spreadRadius: 0.0, // Spread radius
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Hospitals',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.only(
                  top: 5.0,
                ),
                height: 60.0,
                decoration: BoxDecoration(
                  color: Color(0xFF2A2B3F),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0), // Adjust the radius as needed
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "No more ads !",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'subscribe to ehs+ for seamless view',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: 16.0), // Set left margin (adjust the value as needed)
              child: Text(
                'Camps',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),

            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(
                    top: 5.0, left: 5.0, right: 5.0, bottom: 2.0),
                height: 100.0, // Set a fixed height for the Container
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Scroll horizontally
                  itemCount: camps.length,
                  itemBuilder: (BuildContext context, int index) {
                    final color = boxColors[index % boxColors.length];
                    return GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => campdetailed(
                                  title: camps[index]["title"],
                                  age: camps[index]["age"],
                                  enddate: camps[index]["end_date"],
                                  boost: camps[index]["boost"],
                                  id: camps[index]["HospitalID"],
                                  // pin: camps[index]["pin"]
                                )))
                      },
                      child: Container(
                        width:
                            150.0, // Set a fixed width for each item (adjust as needed)
                        margin: EdgeInsets.only(right: 5.0, left: 5.0),
                        decoration: BoxDecoration(
                          // color: color,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [color.withOpacity(0.4), color],
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius as needed
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Shadow color
                              offset: Offset(0, 3), // Offset of the shadow
                              blurRadius: 5.0, // Blur radius
                              spreadRadius: 0.0, // Spread radius
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            camps[index]["title"],
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16.0), // Set left margin (adjust the value as needed)
              child: Text(
                'Doctor',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(
                    top: 5.0, left: 5.0, right: 5.0, bottom: 2.0),
                height: 100.0, // Set a fixed height for the Container
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Scroll horizontally
                  itemCount: doctors.length,
                  itemBuilder: (BuildContext context, int index) {
                    final color = boxColors[index % boxColors.length];
                    return GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => doctordetailed(
                              hid: doctors[index]["hospitalID"],
                              did: doctors[index]["docID"],
                              email: doctors[index]["email"],
                              fullname: doctors[index]["fullname"],
                              phone: doctors[index]["phone"],
                              speciality: doctors[index]["speciality"]),
                        ))
                      },
                      child: Container(
                        width:
                            150.0, // Set a fixed width for each item (adjust as needed)
                        margin: EdgeInsets.only(right: 5.0, left: 5.0),
                        decoration: BoxDecoration(
                          // color: color,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              color.withOpacity(0.2),
                              color.withOpacity(0.4),
                              color,
                              Colors.black
                            ],
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius as needed
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Shadow color
                              offset: Offset(0, 3), // Offset of the shadow
                              blurRadius: 5.0, // Blur radius
                              spreadRadius: 0.0, // Spread radius
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                doctors[index]["fullname"],
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              Text(
                                doctors[index]["speciality"],
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Container(
            //   height: 100.0, // Set a fixed height for the Container
            //   margin: EdgeInsets.only(
            //       left: 5.0, right: 5.0, top: 5.0, bottom: 10.0),

            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal, // Scroll horizontally
            //     itemCount: docs.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       final color = boxColors[index % boxColors.length];
            //       return Container(
            //         width:
            //             150.0, // Set a fixed width for each item (adjust as needed)
            //         margin: EdgeInsets.only(right: 5.0, left: 5.0),
            //         decoration: BoxDecoration(
            //           color: color,
            //           borderRadius: BorderRadius.circular(
            //               10.0), // Adjust the radius as needed
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.grey, // Shadow color
            //               offset: Offset(0, 3), // Offset of the shadow
            //               blurRadius: 5.0, // Blur radius
            //               spreadRadius: 0.0, // Spread radius
            //             ),
            //           ],
            //         ),
            //         child: Center(
            //           child: Text(
            //             docs[index],
            //             style: TextStyle(fontSize: 20.0),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),

            Container(
              // margin: EdgeInsets.only(top: 10.0), // Adjust the height as needed

              padding: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Center the icons horizontally
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        size: 25.0,
                      ),
                      onPressed: () {
                        // Handle the Home icon press
                      },
                    ),
                    IconButton(
                      icon: Text(
                        '🩸',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => blood()),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.scanner,
                        size: 25.0,
                      ),
                      onPressed: () {
                        // Handle the Notification icon press
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => uprof()),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 25.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => prescription()),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.note,
                        size: 25.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => newdata()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Add more children as needed
            SizedBox(
              height: 1.0,
            )
          ],
        ),
      ),
    );
  }
}
