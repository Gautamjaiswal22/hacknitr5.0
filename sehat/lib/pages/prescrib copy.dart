import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class prescrib extends StatefulWidget {
  final String name;
  const prescrib({
    super.key,
    required this.name,
  });

  @override
  State<prescrib> createState() => _prescribState();
}

class _prescribState extends State<prescrib> {
  @override
  late String op = "";
  Future<String?> getEhsidFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ehsid = prefs.getString('ehsid');
    setState(() {
      op = ehsid!;
    });
    print(op);
    return ehsid;
  }

  List<dynamic> users = [];
  Future<void> fetchData() async {
    try {
      print("hue hue ");
      var url = Uri.parse('https://ehs-q3hx.onrender.com/api/fetchUser/$op');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        // print(responseData);
        setState(() {
          users = json.decode(response.body);
          print(users);
          // print(hospdetails["status"]);
          // hospitals = hospdetails["data"];
        });
        // Set your data here using setState or any other method suitable for your app
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getEhsidFromLocalStorage();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              SizedBox(
                width: 151.0,
                height: 39.0,
                child: ElevatedButton(
                  onPressed: () async {
                    await fetchData();
                  },
                  // style: ElevatedButton.styleFrom(
                  //   primary: Color(0xFFE55771),
                  // ),
                  child: Text(
                    'Get history',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Press the button to get the history"),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(users.length, (index) {
                        List<dynamic> reports = users[index]['reports'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'health History of ${widget.name} ',
                              style: TextStyle(
                                fontSize: 24, // Set the font size
                                fontWeight: FontWeight
                                    .bold, // Set the font weight to bold
                                color: Colors.blue, // Set the text color
                                // You can add more styles as needed, such as fontFamily, letterSpacing, etc.
                              ),
                            ),
                            Column(
                              children: reports.map((report) {
                                return Card(
                                  margin: EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Title: ${report['title']}'),
                                          // Text('File URL: ${report['fileURL']}'),
                                          Text(
                                              'Symptoms: ${report['symptoms']}'),
                                          Text('Date: ${report['date']}'),
                                          // Text('_ID: ${report['_id']}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
