import 'package:flutter/material.dart';

class doctordetailed extends StatefulWidget {
  final String hid;
  final String did;
  final String email;
  final String fullname;
  final String phone;
  final String speciality;

  const doctordetailed({
    super.key,
    required this.hid,
    required this.did,
    required this.email,
    required this.fullname,
    required this.phone,
    required this.speciality,
  });

  @override
  State<doctordetailed> createState() => _doctordetailedState();
}

class _doctordetailedState extends State<doctordetailed> {
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
                          "Dr.${widget.fullname}",
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
                            Text(widget.speciality),
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
                        child: Container(
                          margin: EdgeInsets.all(7.0),
                          padding: EdgeInsets.all(10.0),
                          width: double.infinity,
                          height: 60.0,
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
                            children: [Text('DoctorId'), Text(widget.did)],
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(10.0),
                          width: double.infinity,
                          height: 60.0,
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
                            children: [Text("Hospital id"), Text(widget.hid)],
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(10.0),
                          width: double.infinity,
                          height: 60.0,
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
                              Text("Contact Number"),
                              Text(widget.phone)
                            ],
                          ),
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
                            Text("Email"),
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
