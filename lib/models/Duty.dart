class Duty{
  int _duty_id,_teacher_id,_class_no, _day;
  String _date,_time,_status,_month,_reason,_teacher_name;

  Duty(this._teacher_id,this._date,this._time,this._class_no);

  

  int get duty_id =>  _duty_id;
  int get teacher_id => _teacher_id;
  int get class_no => _class_no;
  int get day => _day;
  
  String get date => _date;
  String get time => _time;
  String get status => _status;
  String get month => _month;
  String get teacher_name =>_teacher_name;
  
 
  set teacher_id(int tid){
    this._teacher_id=tid;
  }
  set class_no(int cno){
    this._class_no=cno;
  }
  set date(String dt){
    this._date=dt;
  }
  set time(String time){
    this._time=time;
  }

  set day(int day){
    this._day=day;
  }

  set month(String month){
    this._month=month;
  }

  set teacher_name(String teacher_name){
    this._teacher_name=teacher_name;
  }

  Map<String,dynamic> toMap(){
    var map=new Map<String,dynamic>();
   // map['Duty_id']=_duty_id;
    map['Teacher_id']=_teacher_id;
    map['Class_no']=_class_no;
    map['Date']=_date;
    map['Time']=_time;
    //map['status']=_status;
    //map['Reason']=_reason;
     
    return map;
  }

  Duty.fromMap(Map<String,dynamic> obj){
    this._duty_id= obj['Duty_id'];
    this._teacher_id=obj['Teacher_id'];
    this._class_no=obj['Class_no'];
    this._date=obj['Date'];
    this._time=obj['Time'];
    this._status=obj['status'];
    this._reason=obj['Reason'];
  }

}