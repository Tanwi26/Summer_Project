import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/CtrQuery/login_ctr.dart';
import 'package:exam_arrangement/data/database_helper.dart';
import "package:exam_arrangement/models/Duty.dart";
import 'package:exam_arrangement/models/user.dart';

class AddDuty extends StatefulWidget{
  final String appBarTitle;
  final Duty d;
  AddDuty(this.d,this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    
        return AddDutyState(this.d,this.appBarTitle);
  
  }

}

class AddDutyState extends State<AddDuty>{
   String appBarTitle;
   Duty d;
   AddDutyState(this.d,this.appBarTitle);
   
  List<String> teachers=["pooja","priyal","tanwi"];
  TextEditingController text_class_no=TextEditingController();
   TextEditingController text_date=TextEditingController();
   TextEditingController text_time=TextEditingController();
   String _selectedDate = 'Tap to select date';
   String _selectedTime='tap to select time';
    LoginCtr con=LoginCtr();
   TimeOfDay _time=new TimeOfDay.now();
   List<DropdownMenuItem<String>> teachersList=[];
   var teacher_name;
   void initState(){
     super.initState();
     con.getAllUser().then((value){
       value.map((map){
         return getDropDownWidget(map);
       }).forEach((dropDownItem) { 
         teachersList.add(dropDownItem);
       });
        if(d.duty_id!=null){
        text_class_no.text=d.class_no.toString();
         text_date.text=d.date;
          text_time.text=d.time;}
       setState(() {});
     });

   }
   DropdownMenuItem<String> getDropDownWidget(User map){
     return  DropdownMenuItem<String>(
       value: map.username,
       child: Text(map.username,style: TextStyle(fontSize:20),),
     );
   }
  
   _selectDate(BuildContext context) async {
    Future<DateTime> d = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2021),
    );
    d.then((value) => {
      setState(() {
        text_date.text = new DateFormat('dd-MM-yyyy').format(value);
      })
    });
      /*setState(() {
        _selectedDate = new DateFormat('dd-MM-yyyy').format(d);
        
      });
      return _selectedDate;*/
  }
 /* String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
}*/
   _selectTime(BuildContext context) async{
    Future<TimeOfDay> picked= showTimePicker(
      context:context,
      initialTime:_time
    );
    picked.then((value) =>{
      if(value!=null){
        setState(() {
          var hr, min, type = 'AM';
          debugPrint(value.hour.toString());
        if(value.hour > 12) {
          hr = value.hour - 12;
          type = 'PM';
        } else if (value.hour == 12) {
          type = 'PM';
        } else {
          hr = value.hour;
        }
        hr=hr.toString();
        min = value.minute.toString();
        hr = hr.length == 1 ? '0' + hr : hr;
        min = min.length == 1 ? '0' + min : min;
       text_time.text=hr + ':' + min + ' ' + type;
          _time=value;
          
    })}}
    
    );
        
        
    }

    void getTeacherId(String value) async{
      var result=await con.getIdByTeacher(value);
       d.teacher_id=result[0]['id'];

    }

    
     
  
  String item="tanwi";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   
    return new Scaffold(
       appBar: new AppBar(
        title: new Text(
          appBarTitle,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon:Icon(
            Icons.arrow_back),
            onPressed: (){
                Navigator.pop(context);
            },
          ),
        backgroundColor: Colors.amber[600],),
        
      

        body: new Padding(
            padding: EdgeInsets.only(top:15.0,left: 10.0,right: 10.0),
            child: new ListView(
              children:<Widget>[
                Text("Teacher",style:TextStyle(fontSize:20,color: Colors.red[600])),
                ListTile(
                title:DropdownButton<String>(
                  isExpanded: true,
                  
                  items:teachersList,
                  style: TextStyle(fontSize:30,color:Colors.red[600]),
                  value:item,
                //  onTap:(){ getTeacher();},
                  onChanged: (val){
                    setState(() {
                      item=val;
                      debugPrint(val);
                      getTeacherId(item);
                    });
                  },
                  
                ),),
                Padding(
                  padding:EdgeInsets.only(top:15.0,bottom:15.0),
                 
                  child:TextField(
                      controller: text_class_no,
                      style: TextStyle(fontSize:20,color:Colors.red[600]),
                      onChanged: (value){d.class_no=int.parse(text_class_no.text);},
                      decoration: InputDecoration(
                        labelText: 'Classroom',
                        labelStyle: TextStyle(fontSize:15,color:Colors.red[600]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color:Colors.red[600])),
                         
                      ),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(top:15.0,bottom:15.0),
                  child: Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children:<Widget>[
                    Expanded(
                     flex: 5, 
                      child:Material(
                        child:InkWell(
                          
                     child:TextField(
                      controller: text_date,
                      
                      style: TextStyle(fontSize:20,color:Colors.red[600]),
                      decoration: InputDecoration(
                        labelText: 'Date',
                        labelStyle: TextStyle(fontSize:20,color:Colors.red[600]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.red[600])),
                      ),
                     
                      onChanged: (value){
                        d.date=text_date.text;
                      },
                      ),
                       onTap: () {
                        _selectDate(context);
                      
                      },
                      
                          ),
                      
                    ),),
                  Expanded(
                    flex: 1,
                  child:IconButton(
                    icon:Icon(Icons.calendar_today),
                    tooltip: 'Tap to open date picker',
                      onPressed: () {
                        _selectDate(context);
                        
                      },
                    ),),],
                  )
      
                ),
                  Padding(
                  padding:EdgeInsets.only(top:15.0,bottom:15.0),
                  child: Row(
                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children:<Widget>[
                    Expanded(
                      flex:5,
                      child:Material(
                   child: InkWell(
                   child: TextField(
                      controller: text_time,
                      
                      style: TextStyle(fontSize:20,color:Colors.red[600]),
                      decoration: InputDecoration(
                        labelText: 'Time',
                        labelStyle: TextStyle(fontSize:20,color:Colors.red[600]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.red[600])),
                      ),
                      onChanged: (value){
                        d.time=text_time.text;
                      },),
                      onTap: (){
                        _selectTime(context);
                        text_time.text=_selectedTime;
                        debugPrint(text_time.text);
                      
                      },

                      
                  ),),),
                  Expanded(
                    flex: 1,
                  child:IconButton(
                    icon:Icon(Icons.alarm),
                    tooltip: 'Tap to open date picker',
                      onPressed: () {
                        _selectTime(context);
                        text_time.text=_selectedTime;
                        debugPrint(text_time.text);
                      },
                    ),),],
                  )
      
                ),
                 Padding(
                     padding: EdgeInsets.only(top:15.0,bottom:15.0),
                     child: Row(
                    children: <Widget>[
                      Expanded(
                        child:RaisedButton(
                          color:Colors.red[600],
                          textColor:Colors.white,
                          child:Text(
                            'Save',
                            textScaleFactor:1.5,
                          ),
                          onPressed:(){
                            setState((){
                              _save();
                              Navigator.pop(context,true);
                              debugPrint("save");
                            });
                          }
                        )
                      ),
                      Container(width:5.0),
                      Expanded(
                        child:RaisedButton(
                          color:Colors.red[600],
                          textColor:Colors.white,
                          child:Text(
                            'Cancel',
                            textScaleFactor:1.5,
                          ),
                          onPressed:(){
                            setState((){
                              Navigator.pop(context);
                              debugPrint("cancel");
                            });
                          }
                        )
                      )
                    ],),
               ),

                    
                  
                

              ],
            ),
        ),
       
    );
  }

  void _save() async{
    int result;
    d.date=text_date.text;
    d.time=text_time.text;
    if(d.duty_id!=null){
     result= await con.updateDuty(d);
    }
    else{
      result=  await con.insertDuty(d);
    }
    if(result!=0){
      _showAlertDialog('Status','Duty Added');
    }
    else{
        _showAlertDialog('Status','Problem adding duty');
    }
  }
  void _showAlertDialog(String title,String msg){
    AlertDialog alert=AlertDialog(content: Text(msg),title: Text(title),);
    showDialog(context:context,builder:(_)=>alert);
  }
}