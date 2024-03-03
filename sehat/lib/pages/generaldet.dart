import 'package:sehat/pages/newdata.dart';
import 'package:sehat/pages/personal.dart';
import 'package:sehat/pages/prescrib.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GeneralDet extends StatefulWidget {
  final String name;
  GeneralDet({required this.name});
  @override
  State<GeneralDet> createState() => _GeneralDetState();
}

class _GeneralDetState extends State<GeneralDet> {
  final List<List<String>> dataArrays = [
    ['Data 1A', 'Data 2A'],
    ['Data 1B', 'Data 2B'],
    // Add more arrays as needed
  ];

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
            Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(
                        context); // Navigate back when the icon is tapped
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 36.0,
                    color: Colors.black,
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'General Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            'Generalized data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'your height, weight and other data',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => personal()));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20.0,
                        color: Colors.black,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Diagnosis Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  'Add New Data',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '    Doctor prescribtion , report',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 80.0,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => newdata()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20.0,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(16.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Align(
                      alignment:
                          Alignment.center, // Center the text horizontally
                      child: Text('Diagnosis History'),
                    ),
                  ),
                  Container(
                      height: 300.0,
                      child: ListView(
                        children: [
                          for (int i = 0; i < min(3, dataArrays.length); i++)
                            Container(
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Text(
                                        dataArrays[i][0],
                                      ),
                                      Text(
                                        dataArrays[i][1],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 200,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(
                                  0xFFE55771), // Replace this with your desired color
                            ),
                            onPressed: () {
                              // Navigate to another page when the button is pressed
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (prescrib(
                                          name: widget.name,
                                        ))),
                              );
                            },
                            child: Container(
                                // margin: EdgeInsets.all(16.0),
                                // padding: EdgeInsets.all(10),
                                child: Text('view more')),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
