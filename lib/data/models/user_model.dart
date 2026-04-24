import 'package:meet8/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.name, required super.email, required super.NoTelepon, required super.alamat});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'NoTelepon' : NoTelepon, 'alamat' : alamat};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(id: map['id'], name: map['name'], email: map['email'], NoTelepon: map['NoTelepon'], alamat: map['alamat']);
  }
}
