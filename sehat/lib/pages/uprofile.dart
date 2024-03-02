import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class uprof extends StatefulWidget {
  const uprof({super.key});

  @override
  State<uprof> createState() => _uprofState();
}

class _uprofState extends State<uprof> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF9F9F9),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 40.0),
              padding: EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 70.0,
                    width: 250.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 60),
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: AssetImage('assets/qr.png'),
                      // ),
                    ),
                    child: QrImageView(
                      data: op,
                      size: 150,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text('ehs ID : ${op}')
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        // Copy 'op' to the clipboard when button is pressed
                        Clipboard.setData(ClipboardData(text: op));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Ehs ID copied to clipboard')));
                      },
                      child: Text('Ehs ID'),
                    ),
                  )),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () {
                              // Share 'op' to other apps when the button is pressed
                              Share.share(op, subject: 'Sharing Ehs ID');
                            },
                            child: Text('Share ID'),
                          )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
