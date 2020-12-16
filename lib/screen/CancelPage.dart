import 'package:flutter/material.dart';
import '../data/CtrQuery/login_ctr.dart';
import 'package:exam_arrangement/data/database_helper.dart';


//import 'DutyPage.dart';

class CancelPage extends StatefulWidget{
  final int dId;
  
  CancelPage({Key key,this.dId}):super(key: key);
  
  
  @override
  _CancelPageState createState() => _CancelPageState(this.dId);
}

class _CancelPageState extends State<CancelPage> {
  final myController=TextEditingController();
  LoginCtr con=new LoginCtr();
  int dId;
  _CancelPageState(this.dId);
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  String getText(){
    String txt=myController.text;
    return txt;
  }

  void update(dId,txt,context) async{
  int value=await con.updateStatus(dId,txt);
  print(value);
  Navigator.pop(context,true);
  }
@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Reason",
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
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new TextFormField(controller: myController,),
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
                        onPressed:()=>update(widget.dId, getText(), context),

                        child: new Text("Submit"),
                        color: Colors.red[900],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed:null,
                        child: new Text("Cancel"),
                        color: Colors.red[900],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
}
}
