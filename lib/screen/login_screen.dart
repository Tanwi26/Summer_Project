import 'package:exam_arrangement/screen/AdminDutyList.dart';
import 'package:exam_arrangement/screen/DutyPage.dart';
import 'package:exam_arrangement/screen/change_password.dart';
import 'package:flutter/material.dart';
import 'package:exam_arrangement/models/user.dart';
import 'package:exam_arrangement/screen/home_page.dart';
import 'package:exam_arrangement/services/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password;

  LoginResponse _response;

  _LoginPageState() {
    _response = new LoginResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {}

    if (form.validate()) {
      if (_username == "admin" && _password == "admin") {
        // savePref(1, _username, _password);
        // setState(() {
        //    _loginStatus = LoginStatus.signIn;
        // });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdminDutyList(signOut:signOut)));
      } else {
        setState(() {
          _isLoading = true;
          form.save();
          _response.doLogin(_username, _password);
        });
      }
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      _username = preferences.getString("user");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        _ctx = context;
        var loginBtn = new RaisedButton(
          onPressed: _submit,
          child: new Text("Sign In"),
          color: Colors.red[600],
        );
        var loginForm = new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new TextFormField(
                        onSaved: (val) => _username = val,
                        decoration: new InputDecoration(labelText: "Username"),
                        //change
                        validator: (val) => val.isEmpty ? 'Enter Email' : null,
                        onChanged: (val) {
                          setState(() => _username = val);
                        }),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new TextFormField(
                        onSaved: (val) => _password = val,
                        decoration: new InputDecoration(labelText: "Password"),
                        validator: (val) => val.length < 4
                            ? 'Enter password 4 chars long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => _password = val);
                        }),
                  )
                ],
              ),
            ),
            loginBtn
          ],
        );

        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              "Sign In",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.amber[600],
          ),
          key: scaffoldKey,
          body: new Container(
            child: new Center(
              child: loginForm,
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        var username,sg;
        return DutyPage(username:_username,signOut:signOut);
        break;
    }
  }

  savePref(int value, String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.commit();
    });
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if (user != null) {
      savePref(1, user.username, user.password);
      _loginStatus = LoginStatus.signIn;
    } else {
      _showSnackBar("Couldnt Sign In");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
