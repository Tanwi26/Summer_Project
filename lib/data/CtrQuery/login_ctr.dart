import 'package:exam_arrangement/models/user.dart';
import 'dart:async';
import 'package:exam_arrangement/data/database_helper.dart';
import 'package:exam_arrangement/models/Duty.dart';

import '../../models/user.dart';
import '../../models/user.dart';

class LoginCtr {
  static final columnDutyId='Duty_id';
  static final columnTeacherId='Teacher_id';
  static final columnClassNo='Class_no';
  static final columnDate='Date';
  static final columnTime='Time';
  static final columnStatus='status';
  DatabaseHelper con = new DatabaseHelper();

//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<User> getLogin(String user, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM user WHERE username = '$user' and password = '$password'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }

  Future<List<User>> getAllUser() async {
    var dbClient = await con.db;
    var res = await dbClient.query("user");

    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;

    return list;
  }



  Future<int> updateUser(User user) async {
    var dbClient = await con.db;
    return await dbClient.rawUpdate(
        'UPDATE user SET password="${user.password}" WHERE username = "${user.username}"');
  }
  FutureOr<dynamic> getIdByUser(String user) async{
    final dbClient= await con.db;
    var id=await dbClient.rawQuery("SELECT id from user WHERE username='$user'");
    return id[0]['id'];
  }
   getTeacherById(int id) async{
    final dbClient= await con.db;
    var name= await dbClient.rawQuery('SELECT username from user where id=$id');
    return name;
  }
  getIdByTeacher(String tname) async{
    final dbClient= await con.db;
    var id=await dbClient.rawQuery("SELECT id from user where username='$tname'");
    return id;
  }

   Future<List<Map<String,dynamic>>> getDuty(int id) async{
      DatabaseHelper con1 = new DatabaseHelper();
        final dbClient=await con1.db;
        List<Map> results= await dbClient.rawQuery('select Duty_id,Class_no,Date,Time,status FROM Duty where Teacher_id=$id AND status="Scheduled"');
        /*var duties=
              results.isNotEmpty ? results.toList().map((c)=>Duty.fromMap(c)) : null;*/
        return results;
        
        }

   Future<List<Duty>> getUserDutyList(int id) async{
        var dutyList=await getDuty(id);
        int cnt=dutyList.length;
        List<Duty> dList=List<Duty>();
        for(int i=0;i< cnt;i++){
          dList.add(Duty.fromMap(dutyList[i]));
        }
        return dList;
      }
    
    Future<int> updateStatus(int id,String txt) async{
      DatabaseHelper con1 = new DatabaseHelper();
      final dbClient=await con1.db;
      //var temp = ;
    var count=await dbClient.rawUpdate('''UPDATE Duty SET status = 'Cancelled', Reason ='$txt' where Duty_id = $id''' );
      return count;
    }

    Future<int> updateDuty(Duty d) async{
       DatabaseHelper con1 = new DatabaseHelper();
      final dbClient=await con1.db;
      var result= await dbClient.update('Duty',d.toMap(), where:'$columnDutyId=?',whereArgs: [d.duty_id]);
      return result;
    }

    Future<int> insertDuty(Duty duty) async{
        DatabaseHelper con1 = new DatabaseHelper();
         final dbClient=await con1.db;
        var result=await dbClient.insert('Duty', duty.toMap());
        return result;
    }

   Future<List<Map<String,dynamic>>> getDutyAdmin() async{
      DatabaseHelper con1 = new DatabaseHelper();
        final dbClient=await con1.db;
        List<Map> results= await dbClient.rawQuery('select * FROM Duty where status="Scheduled"');
        /*var duties=
              results.isNotEmpty ? results.toList().map((c)=>Duty.fromMap(c)) : null;*/
        return results;
        
        }
      Future<List<Duty>> getDutyList() async{
        var dutyList=await getDutyAdmin();
        int cnt=dutyList.length;
        List<Duty> dList=List<Duty>();
        for(int i=0;i< cnt;i++){
          dList.add(Duty.fromMap(dutyList[i]));
        }
        return dList;
      }

      Future<int> deleteDuty(int id) async{
         DatabaseHelper con1 = new DatabaseHelper();
        final dbClient=await con1.db;
        var res=dbClient.rawDelete('DELETE FROM Duty where Duty_id=$id');
        return res;
      }
        
      } 

    

