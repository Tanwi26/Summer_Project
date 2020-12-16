import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exam_arrangement/screen/change_password.dart';

class dashboard extends StatefulWidget {
  String username;

  dashboard(this.username);
  @override
  _dashboardState createState() => _dashboardState(this.username);
}

class _dashboardState extends State<dashboard> {
  String username;
  //signOut() {
  //print("test");
  // setState(() {
  //   widget.signOut();
  // });
  //print("test1");
  //}

  _dashboardState(this.username);

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Admin Dashboard",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber[600],
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {
        //       signOut();
        //     },
        //     icon: Icon(
        //       Icons.lock_open,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: new Center(
        child: new Text("Admin Dashboard"),
        /*child: RaisedButton(
          child: new Text('Open route'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChangePassword(username)));
          },
        ),
        */
      ),
    );
  }
}
