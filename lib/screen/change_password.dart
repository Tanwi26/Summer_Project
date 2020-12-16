import 'package:flutter/material.dart';
import 'package:exam_arrangement/models/user.dart';
import 'package:exam_arrangement/data/database_helper.dart';
import 'package:exam_arrangement/data/CtrQuery/login_ctr.dart';

class ChangePassword extends StatefulWidget {
  //final VoidCallback signOut;
  //
  String username;
  ChangePassword(this.username);
  @override
  _ChangePasswordState createState() => _ChangePasswordState(username);
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = new GlobalKey<FormState>();
  LoginCtr con = new LoginCtr();
  String username;
  String changePassword;
  _ChangePasswordState(this.username);

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        //_isLoading = true;
        form.save();
        print(username);
        User user = User(username, changePassword);
        print("test2");
        con
            .updateUser(user)
            .then((user) => print("success"))
            .catchError((onError) => print("fail"));
        print("test3");
        //_response.doLogin(_username, _password);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Change Password",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber[600],
      ),
      body: new Container(
        child: new Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new TextFormField(
                        onSaved: (val) => changePassword = val,
                        decoration:
                            new InputDecoration(labelText: "Change Password"),
                        //change
                        validator: (val) => val.length < 4
                            ? 'Minimum 4 characters required'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => changePassword = val);
                        }),
                  )
                ],
              ),
            ),
            Center(
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: _submit,
                        child: new Text("Submit"),
                        color: Colors.red[900],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
