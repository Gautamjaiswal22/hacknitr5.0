import 'package:ehs/pages/doctorinhospital.dart';
import 'package:flutter/material.dart';

class detailhosp extends StatefulWidget {
  final String hname;
  final String hid;
  final String ownership;
  final String staffsize;
  final List festures;
  final String address1;
  final String address2;
  final String address3;
  final String city;
  final String state;
  final String email;
  final String mobile;
  final String dbid;
  const detailhosp({
    super.key,
    required this.hname,
    required this.hid,
    required this.ownership,
    required this.staffsize,
    required this.festures,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.city,
    required this.state,
    required this.email,
    required this.mobile,
    required this.dbid,
  });

  @override
  State<detailhosp> createState() => _detailhospState();
}

class _detailhospState extends State<detailhosp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F6FB),
        ),
        child: Column(children: [
          SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 25.0,
                  )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.all(17.0),
            decoration: BoxDecoration(

                //  image: AssetImage('assets/sahil.jpeg'),
                ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Image(
                    image: AssetImage(
                        'assets/hospital.jpg'), // Replace with your image asset path
                    // Set the height of the image
                    width: 320.0,
                    height: 150.0,

                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(9), // Apply border radius
                    color: Colors.white, // Set background color to #FFF
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0, 2),
                        blurRadius: 8,
                        spreadRadius: -3,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment:
                            Alignment.center, // Align the child to the center
                        child: Text(
                          widget.hname,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(7.0),
                        child: Column(
                          children: [
                            Text(widget.address1),
                            Text(widget.address2),
                            Text(widget.address3),
                            Row(
                              children: [
                                SizedBox(
                                  width: 70.0,
                                ),
                                Text(widget.city),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(widget.state)
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // Align the row's content to the start (left)

                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(7.0),
                              padding: EdgeInsets.all(10.0),
                              width: 120.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    9), // Apply border radius
                                color: Colors
                                    .white, // Set background color to #FFF
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                    spreadRadius: -3,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text('Type'),
                                  Text(widget.ownership)
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            Container(
                              margin: EdgeInsets.all(7.0),
                              padding: EdgeInsets.all(10.0),
                              width: 120.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    9), // Apply border radius
                                color: Colors
                                    .white, // Set background color to #FFF
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                    spreadRadius: -3,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text('staff'),
                                  Text('${widget.staffsize}+')
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(7.0),
                              padding: EdgeInsets.all(10.0),
                              width: 120.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    9), // Apply border radius
                                color: Colors
                                    .white, // Set background color to #FFF
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                    spreadRadius: -3,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text("Features"),
                                  Text(widget.festures[0])
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            Container(
                              margin: EdgeInsets.all(7.0),
                              padding: EdgeInsets.all(10.0),
                              width: 120.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    9), // Apply border radius
                                color: Colors
                                    .white, // Set background color to #FFF
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                    spreadRadius: -3,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text("Features"),
                                  Text(widget.festures[1])
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(10.0),
                              width: 120.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    9), // Apply border radius
                                color: Colors
                                    .white, // Set background color to #FFF
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                    spreadRadius: -3,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text("Features"),
                                  Text(widget.festures[2])
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        doctorinh(hid: widget.dbid),
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  padding: EdgeInsets.all(10.0),
                                  width: 120.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        12), // Apply border radius
                                    color: Color(
                                        0xFFE55771), // Set the background color
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.3), // Shadow color
                                        offset: Offset(
                                            0, 3), // Position of the shadow
                                        blurRadius: 6, // Spread of the shadow
                                        spreadRadius:
                                            0, // Expansion of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "View Doctors",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Set text color to white
                                        fontSize:
                                            12, // Adjust text size as needed
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(20.0),
                        // width: 120.0,
                        // height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(9), // Apply border radius
                          color: Colors.white, // Set background color to #FFF
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(0, 2),
                              blurRadius: 8,
                              spreadRadius: -3,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(widget.mobile),
                            Text(widget.email),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Call the submitForm method here
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color(
                //         0xFFE55771), // Replace this with your desired color
                //   ),
                //   child: Text('book appointment'),
                // ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
