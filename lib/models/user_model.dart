import '../database_provider/app_database.dart';

class UserModel {
  int? uid;
  String email;
  String password;
  String address;
  String gender;
  String mobNo;

  UserModel({
    this.uid,
    required this.email,
    required this.password,
    required this.address,
    required this.gender,
    required this.mobNo,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map[AppDataBase().USER_COLUMN_ID],
      email: map[AppDataBase().USER_COLUMN_EMAIL],
      password: map[AppDataBase().USER_COLUMN_PASS],
      address: map[AppDataBase().USER_COLUMN_ADDR],
      gender: map[AppDataBase().USER_COLUMN_GENDER],
      mobNo: map[AppDataBase().USER_COLUMN_MOBNO],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppDataBase().USER_COLUMN_ID: uid,
      AppDataBase().USER_COLUMN_EMAIL: email,
      AppDataBase().USER_COLUMN_PASS: password,
      AppDataBase().USER_COLUMN_ADDR: address,
      AppDataBase().USER_COLUMN_GENDER: gender,
      AppDataBase().USER_COLUMN_MOBNO: mobNo,
    };
  }
}
