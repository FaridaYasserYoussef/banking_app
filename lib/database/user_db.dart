import 'dart:math';

import 'package:faker/faker.dart';
import 'package:sqflite/sqflite.dart';
import 'database_service.dart';
import 'package:banking_system/models/user.dart';



class UserDB{

  final tableName = "users";


  Future<void> createUserTable(Database database) async{
    print("in create user table");

    await database.execute("""CREATE TABLE IF NOT EXISTS "${tableName}"(
	"user_id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	"email"	TEXT NOT NULL,
	"password"	TEXT NOT NULL,
	"gender"	TEXT NOT NULL,
	"balance"	REAL NOT NULL, 
	PRIMARY KEY("user_id" AUTOINCREMENT)
);""");



  }


  Future<void> createTenRandomUsers() async{
    for(int i = 0; i < 10; i++){
      String randomlyGeneratedName = faker.person.name();
      print(await UserDB().createUser(name: randomlyGeneratedName , email: randomlyGeneratedName.replaceAll(" ", ".")+"@gmail.com", password: "12345abcd", gender: i % 2 == 0 ? "female" : "male", balance: Random().nextDouble() * 10000));

    }
  }

  Future<int> createUser({required String name, required String email, required String password, required String gender, required double balance}) async{
    final Database database = await  DatabaseService().database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (name, email, password, gender,  balance) VALUES (?,?,?,?,?)''',
        [name, email, password, gender, balance]
    );
  }

  Future<List<User>> fetchAllUsers() async{
    final Database database = await  DatabaseService().database;
    final users = await database.rawQuery('''SELECT * FROM $tableName''');
    return users.map((eachUserMap) => User.fromSqfliteDatabase(eachUserMap)).toList();

  }

  Future<User> fetchUserById(int userId) async{
    print( "in fetch user");
    final Database database = await DatabaseService().database;
    final user = await database.rawQuery('''SELECT * FROM $tableName WHERE user_id = ?''', [userId]);
    print(user);
    return User.fromSqfliteDatabase(user.first);
  }

  Future<int> updateUserBalance(int userId, double changeInBalance) async{
    final user = await fetchUserById(userId);
    double newAmount = user.balance + changeInBalance;
    final database = await  DatabaseService().database;
    return await database.update(tableName, {'balance': newAmount}, where: "user_id = ?", whereArgs: [userId]);
  }
  
  
  Future<List<User>> getUserContactsList(User currentUser) async{

    List<User> users = await UserDB().fetchAllUsers();
    users.removeWhere((element) => element.user_id == currentUser.user_id);
    return users;
    
  }



}