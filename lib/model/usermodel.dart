import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String cpf;
  final String phone;
  final String email;
  final String? id;

  UserModel(
      {required this.name,
      required this.cpf,
      required this.phone,
      required this.email,
      this.id});

  //do firestore para dados

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id, // Atribui o ID
      name: json['name'],
      cpf: json['cpf'],
      phone: json['phone'],
      email: json['email'],
    );
  }

//dados para firestore
  toJson() {
    return {'name': name, 'cpf': cpf, 'phone': phone, 'email': email, 'id': id};
  }
}
