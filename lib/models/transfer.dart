class Transfer{
final int id;
final int senderId;
final int receiverId;
final DateTime dateTime;

final double amount;

  Transfer({required this.id, required this.senderId, required this.receiverId, required this.dateTime, required this.amount});

  factory Transfer.fromSqfliteDatabase(Map<String, dynamic> map)=>Transfer(
      id: int.parse(map["id"].toString().trim()),
      senderId: int.parse(map["senderId"].toString().trim()),
      receiverId: int.parse(map["receiverId"].toString().trim()),
      dateTime: DateTime.parse(map["createdAt"].toString()),
      amount: double.parse(map["amount"].toString().trim())
  );

}