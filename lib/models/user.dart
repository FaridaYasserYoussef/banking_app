class User{
final int user_id;
final String name;
final String email;
final String password;
final String gender;
final double balance;

  User({required this.user_id, required this.name, required this.email, required this.password, required this.gender, required this.balance});

  factory User.fromSqfliteDatabase(Map<String, dynamic> map)=> User(
      user_id: int.parse(map["user_id"].toString().trim()),
      name: map["name"].toString(),
      email: map["email"].toString(),
      password: map["password"].toString(),
      gender:map["gender"].toString() ,
      balance: double.parse(map["balance"].toString().trim())
  );

}