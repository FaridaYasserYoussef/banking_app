import 'package:banking_system/models/transfer.dart';
import 'package:sqflite/sqflite.dart';
import 'database_service.dart';
import 'package:banking_system/models/user.dart';

class TransferDB{
  final tableName = "transfers";

  Future<void> createTable(Database database) async{
    await database.execute(
        """CREATE TABLE IF NOT EXISTS $tableName (
	"id"	INTEGER NOT NULL,
	"senderId"	INTEGER NOT NULL,
	"receiverId"	INTEGER NOT NULL,
	"amount"	REAL NOT NULL,
	"createdAt" DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT)
);"""
    );
  }


  Future<int> createTransfer({required int senderId, required int receiverId, required double amount}) async{
    final Database database = await  DatabaseService().database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (senderId, receiverId, amount) VALUES (?,?,?)''',
        [senderId.toString(), receiverId.toString(), amount.toString()]
    );
  }


  Future<List<Transfer>> fetchAllTransfers() async{
    final Database database = await DatabaseService().database;
    final transfers = await database.rawQuery('''SELECT * FROM $tableName''');
    return transfers.map((eachTransferMap) => Transfer.fromSqfliteDatabase(eachTransferMap)).toList();

  }

  Future<List<Transfer>> fetchTransfersBySenderAndReceiverId(int senderId, int receiverId) async{
    final Database database = await  DatabaseService().database;
    final transfers = await database.rawQuery('''SELECT * FROM $tableName WHERE (senderId = ? AND receiverId = ?) OR (senderId = ? AND receiverId = ?)''', [senderId, receiverId, receiverId, senderId]);
    return transfers.map((eachTransferMap) => Transfer.fromSqfliteDatabase(eachTransferMap)).toList();

  }


  Future<Transfer> fetchTransferById(int transferId) async{
    final Database database = await DatabaseService().database;
    final transfer = await database.rawQuery('''SELECT * FROM $tableName WHERE id = ?''', [transferId.toString()]);
    return Transfer.fromSqfliteDatabase(transfer.first);
  }


}