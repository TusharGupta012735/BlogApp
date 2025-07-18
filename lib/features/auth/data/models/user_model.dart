import 'package:blog_app/core/common/entities/user.dart';

//copy with method to extend the user obtained from table of supabase with email, written using copilot
extension UserModelCopyWith on UserModel {
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
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
