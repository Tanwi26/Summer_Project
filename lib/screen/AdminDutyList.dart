import 'dart:async';

import 'package:exam_arrangement/screen/AddDuty.dart';
import 'package:flutter/material.dart';
import '../data/CtrQuery/login_ctr.dart';
import '../data/CtrQuery/login_ctr.dart';
import 'CancelPage.dart';
import 'package:exam_arrangement/data/database_helper.dart';
import "package:exam_arrangement/models/Duty.dart";
import 'package:exam_arrangement/screen/login_screen.dart';
import 'package:exam_arrangement/data/CtrQuery/login_ctr.dart';
import 'package:date_format/date_format.dart';
import 'package:flushbar/flushbar.dart';
import 'login_screen.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:intl/intl.dart';





class AdminDutyList extends StatefulWidget{
  final username;
  final VoidCallback signOut;
  
  AdminDutyList({Key key,this.username,this.signOut}): super(key:key);
  
  _AdminDutyListState createState() => _AdminDutyListState();
  
  }
  
  class _AdminDutyListState extends State<AdminDutyList>{
     @override

   signOut() {
    setState(() {
      widget.signOut();
    });
  }

  

 
  var id,duty_id,teacher_id,teacher_name;
  
  LoginCtr con=new LoginCtr();
  List<Duty> duties= new List();
  List<Duty> dList= new List();

  Future<String> getTeacherName() {
     con.getTeacherById(teacher_id).then((value){

     }
     );
  }
 void getData() async{
  // id= await con.getDutyAdmin();
  List<Duty> dutyList= await con.getDutyList();
   //dutyList.then((duty){
      for(Duty d in dutyList) {
          duty_id=d.duty_id;
          teacher_id=d.teacher_id;
          var tname=await con.getTeacherById(teacher_id);
          d.teacher_name = tname[0]['username'];
          DateTime tempDate = new DateFormat("dd-MM-yyyy").parse(d.date);
          d.day=tempDate.day;
          d.month=DateFormat.MMM().format(tempDate);
          dList.add(d);
     }
      setState((){
        duties=dList;
        
          
        
      });
      print(duties);

 //});
 
 }
  

  void initState() {
    super.initState();
    //id=await con.getIdByUser('priyal');
    getData();
    }
     
  void form(List d){
    
    for(int i=0;i<duties.length;i++){
      var day;
      String date=duties[i].date;
      DateTime tempDate = new DateFormat("dd-MMM-yyyy").parse(date);


      List dt=date.split("/");
      day=dt[0];
    }
  }
  Future<int> delete(BuildContext ctxt,Duty duty) async{
    int result=await con.deleteDuty(duty.duty_id);
    return result;
    }

  void navigate(Duty d,String title) async{
  bool res=await Navigator.push(context, 
                              MaterialPageRoute(
                                builder:(context){return AddDuty(d, title);}),);
  if(res==true){
     duties.clear();
     dList.clear();
    List<Duty> dutyList= await con.getDutyList();
    for(Duty d in dutyList) {
          duty_id=d.duty_id;
          teacher_id=d.teacher_id;
          var tname=await con.getTeacherById(teacher_id);
          d.teacher_name = tname[0]['username'];
          DateTime tempDate = new DateFormat("dd-MM-yyyy").parse(d.date);
          d.day=tempDate.day;
          d.month=DateFormat.MMM().format(tempDate);
          dList.add(d);
           
     }
      print(dList);
      setState(() {
       
        this.duties=dList;
      });
    
  }
  }

  
  int a,b;

  Widget build(BuildContext ctxt){
    return new Scaffold(
       appBar: new AppBar(
        title: new Text(
          "Duties",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber[600],
        actions: <Widget>[
          IconButton(
            onPressed: (){
                navigate(Duty(a,'','',b), 'Add Duty');},
            icon: Icon(
              Icons.add,
              color:Colors.black,
            ),
          ),
          
          IconButton(
            onPressed: () {
              signOut();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.lock_open,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: new Container(
        color: Color(0xE7B909),
      child:new ListView.builder
            ( 
              padding: EdgeInsets.only(top:10,left: 10,right: 10,),
              itemCount: duties.length,
              itemBuilder: (BuildContext context,int index){
                  return Container(
                    height:100,
                  
                  child:Card(
                    child: ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                          
                          children: <Widget>[
                            Text(duties[index].day.toString(), style: TextStyle(fontSize: 30),),
                            Text(duties[index].month)
                            
                          ],
                          ),
                          VerticalDivider(
                            color: Colors.grey[150],
                            thickness: 2,
                            width:20,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ],
                      ),
                      title:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
              
                        children: 
                        <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(left:8.0,right:8.0),
                                      child: Text("Teacher:"+duties[index].teacher_name.toString(),style: TextStyle(color:Colors.grey,fontSize:20,fontStyle: FontStyle.italic),)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0,right:8.0),
                                    child: Text("Class:"+duties[index].class_no.toString(),style: TextStyle(color:Colors.grey,fontSize:20,fontStyle: FontStyle.italic),)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0,right:8.0,bottom:8.0),
                                    child: Text("Time:"+duties[index].time,style: TextStyle(color:Colors.grey,fontSize:20,fontStyle: FontStyle.italic),)
                                  ),
                                 
                                  

                              ],
                           
                      ),
                      trailing: 
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 30.0,
                          color: Colors.red,
                        ) ,
                        onPressed:(){
                         // bool i=showAlertDialog(ctxt);
                          //print(i);
                          showAlertDialog(context).then((bool value){
                              if(value){
                            var r=delete(ctxt, duties[index]);
                            if(r!=0){
                            
                              setState(() {
                              duties.removeAt(index);
                            });
                          }
                          }});
                          /*if(i){
                            var r=delete(ctxt, duties[index]);
                            if(r!=0){
                            
                              setState(() {
                              duties.removeAt(index);
                            });
                          }*/
                        }
                        
                      ),
                      onTap: (){
                      navigate(this.duties[index],'Edit Duty');
                      },
                  )
                  )
                  );
                 }
                   
                ),
      )   
              );
            }
    


         Future<bool> showAlertDialog(BuildContext context) {
  // set up the buttons
              Widget cancelButton = FlatButton(
              child: Text("Cancel"),
              onPressed:  () {
               Navigator.of(context).pop(false);  
              },
              );
            Widget continueButton = FlatButton(
              child: Text("Continue"),
              onPressed:  () {
                Navigator.of(context).pop(true);
              },
            );
  // set up the AlertDialog
          AlertDialog alert = AlertDialog(
          title: Text("AlertDialog"),
          content: Text("Do you want to delete this duty?"),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
  // show the dialog
       return showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
              return alert;
            },
        );
}

}


