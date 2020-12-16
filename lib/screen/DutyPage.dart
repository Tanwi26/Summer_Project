import 'package:flutter/material.dart';
import '../data/CtrQuery/login_ctr.dart';
import '../data/CtrQuery/login_ctr.dart';
import 'CancelPage.dart';
import 'package:exam_arrangement/data/database_helper.dart';
import "package:exam_arrangement/models/Duty.dart";
import 'package:exam_arrangement/screen/login_screen.dart';
import 'package:exam_arrangement/data/CtrQuery/login_ctr.dart';
import 'package:date_format/date_format.dart';
import 'package:exam_arrangement/screen/change_password.dart';
import 'login_screen.dart';

import 'package:intl/intl.dart';





class DutyPage extends StatefulWidget{
  final username;
  final VoidCallback signOut;
  
  DutyPage({Key key,this.username,this.signOut}): super(key:key);
  
  _DutyPageState createState() => _DutyPageState(this.username,this.signOut);
  
  }
  
  class _DutyPageState extends State<DutyPage>{
    String username;
    VoidCallback signOut1;
    _DutyPageState(this.username,this.signOut1);


     @override

   signOut() {
    setState(() {
      widget.signOut();
    });
  }

  

  List<String> titles=["class:201","202"];
  var id,duty_id;
  List<String> time=["Time:3:00PM","400"];
  LoginCtr con=new LoginCtr();
  List<Duty> duties= new List();

 void getData() async{
   id= await con.getIdByUser(widget.username);
    con.getUserDutyList(id).then((duty){
      setState((){
        duty.forEach((d){
          duty_id=d.duty_id;
          DateTime tempDate = new DateFormat("dd-MM-yyyy").parse(d.date);
           d.day=tempDate.day;
          d.month=DateFormat.MMM().format(tempDate);
        
          duties.add(d);
        });
      });
      print(duties);

    });
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
                                    child: Text("Class:"+duties[index].class_no.toString(),style: TextStyle(color:Colors.grey,fontSize:20,fontStyle: FontStyle.italic),)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0,right:8.0,bottom:8.0),
                                    child: Text("Time:"+duties[index].time,style: TextStyle(color:Colors.grey,fontSize:20,fontStyle: FontStyle.italic,),)
                                  )

                              ],
                           
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          size: 30.0,
                          color: Colors.red,
                        ) ,
                        onPressed:() {
                          
                           Future<bool> res= Navigator.push(ctxt, 
                              MaterialPageRoute(
                                builder:(ctxt) => CancelPage(dId:duties[index].duty_id,))
                            );
                            res.then((value){
                               setState(() {
                              duties.removeAt(index);
                            });
                            });
                             
  
                        },
                      )
                  )
                  )
                  );
                 }
                   
                ),
      )   
              );
            }
}


