import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exam_arrangement/screen/change_password.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback signOut;
  String username;

  HomeScreen(this.signOut, this.username);
  @override
  _HomeScreenState createState() => _HomeScreenState(this.username);
}

class _HomeScreenState extends State<HomeScreen> {
  String username;
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  _HomeScreenState(this.username);

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
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber[600],
        actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(
              Icons.lock_open,
              color: Colors.black,
            ),
          ),
          IconButton(
            // child: new Text('Open route'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePassword(username)));
            },
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: new Center(
        child: new Text("Home Page"),
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
