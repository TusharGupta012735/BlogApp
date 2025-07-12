import 'package:blog_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.name});

  //factory is also a type of constructor that modifies a current instance of the class
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '', //returns  ull if no id
      email: map['email'] ?? '' ,
      name: map['name'] ?? '' ,
    );
  }
}
