
import 'package:banking_system/database/transfer_db.dart';
import 'package:banking_system/database/user_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:faker/faker.dart';
import '../models/user.dart';

class DatabaseService {
  static const _databaseName = "userbankingdb.db";
  static const _databaseVersion = 1;


  DatabaseService._privateConstructor();
  static final DatabaseService _instance = DatabaseService._privateConstructor();
  factory DatabaseService() => _instance;

   Database? _db;

  Future<Database> get database async{
    if(_db == null){
      await init();
      return _db!;
    }
    return _db!;

  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> init() async {

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async{
        try {
          await UserDB().createUserTable(db);
          await TransferDB().createTable(db);
        } catch(e){
          print("error while creating table " + e.toString());
        }
      },
    );

    print(_db!.path);
    try{
    await UserDB().createTenRandomUsers();

    }catch(e){
      print("error while trying to create user  " + e.toString());
    }
    return _db!;
  }

  // SQL code to create the database table




}