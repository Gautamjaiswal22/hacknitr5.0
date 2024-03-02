import 'package:flutter/material.dart';

class campdetailed extends StatefulWidget {
  final String title;
  final int age;
  final String enddate;
  final bool boost;
  final String id;
  // final String pin;
  const campdetailed({
    super.key,
    required this.title,
    required this.age,
    required this.enddate,
    required this.boost,
    required this.id,
    // required this.pin
  });

  @override
  State<campdetailed> createState() => _campdetailedState();
}

class _campdetailedState extends State<campdetailed> {
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
                          "Name: ${widget.title}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                            children: [Text('age'), Text(widget.id)],
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
                            children: [Text("Hospital id"), Text(widget.id)],
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
                              Text("boost"),
                              Text(
                                widget.boost ? 'Yes' : 'No',
                              ),
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
                            Text("pincode"),
                            // Text(widget.pin),
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
