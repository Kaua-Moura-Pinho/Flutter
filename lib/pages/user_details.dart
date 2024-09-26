import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apploja/model/usermodel.dart';
import 'package:apploja/main.dart';

String _user = "";
bool _editForm = false;
String? _editApptId = ''; // Permitir valor nulo

final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  void initState() {
    super.initState();
  }

  String? _service;
  String _searchQuery = ''; // Adicione uma variável para o texto de busca

  final _serviceList = ["Haircut", "Massage", "Manicure", "Pedicure"];
  final _nameController = TextEditingController();
  final _searchController = TextEditingController();
  final _cpfController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      _user = args['name'];
    }

    final nameField = Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: const Color(0xFF00FFFF)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        autofocus: false,
        controller: _nameController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nome Usuário",
          border: InputBorder.none,
        ),
      ),
    );

    final searchField = Container(
      height: 50.0,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: const Color(0xFF00FFFF)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        autofocus: false,
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value; // Atualize a variável de consulta
          });
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Buscar por",
          border: InputBorder.none,
        ),
      ),
    );

    final cpfField = Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: const Color(0xFF00FFFF)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        autofocus: false,
        controller: _cpfController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.credit_card),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "CPF",
          border: InputBorder.none,
        ),
      ),
    );

    final phoneField = Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: const Color(0xFF00FFFF)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        autofocus: false,
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Número de Telefone",
          border: InputBorder.none,
        ),
      ),
    );

    final emailField = Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Color(0xFF00FFFF)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        autofocus: false,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "E-mail",
          border: InputBorder.none,
        ),
      ),
    );

    final btnSubmit = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15),
      color: const Color(0xFF00FFFF),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if (_nameController.text.isNotEmpty &&
              _cpfController.text.isNotEmpty &&
              _phoneController.text.isNotEmpty &&
              _emailController.text.isNotEmpty) {
            UserModel usermodel = UserModel(
              name: _nameController.text,
              cpf: _cpfController.text,
              phone: _phoneController.text,
              email: _emailController.text,
            );

            if (_editForm == true) {
              await updateUser(userModel: usermodel, userId: _editApptId!);
              log("User successfully updated!");
            } else {
              await bookUser(userModel: usermodel);
              log("User successfully booked!");
            }

            setState(() {
              _editApptId = '';
              _nameController.clear();
              _cpfController.clear();
              _phoneController.clear();
              _emailController.clear();
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Por favor, preencha todos os campos!'),
              ),
            );
            log("Please enter all fields!");
          }
        },
        child: Text(
          !_editForm ? "Salvar" : "Alterar",
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Center(
                child: Text("Lojas 1.000",
                    style: TextStyle(
                      fontSize: 24.0,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.5
                        ..color = const Color(0xFF00FFFF),
                    )),
              ),
              const SizedBox(height: 20.0),
              nameField,
              const SizedBox(height: 30.0),
              cpfField,
              const SizedBox(height: 20.0),
              phoneField,
              const SizedBox(height: 30.0),
              emailField,
              const SizedBox(height: 60.0),
              btnSubmit,
              const SizedBox(height: 20.0),
              searchField,
              const SizedBox(height: 20.0),
              buildUserList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: userCollection
          .where('name',
              isGreaterThanOrEqualTo: _searchQuery) // Filtra pelo nome
          .where('name',
              isLessThanOrEqualTo:
                  '$_searchQuery\uf8ff') // Considera a busca por prefixo
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final users = snapshot.data!.docs.map((doc) {
          final user =
              UserModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
          return ListTile(
            title: Text(user.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.email),
                Text('CPF: ${user.cpf}'), // Exibe o CPF
                Text('Telefone: ${user.phone}'), // Exibe o número de telefone
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _editApptId = user.id;
                      _cpfController.text = user.cpf;
                      _emailController.text = user.email;
                      _phoneController.text = user.phone;
                      _nameController.text = user.name;
                      _editForm = true;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    deleteUser(user);
                  },
                ),
              ],
            ),
          );
        }).toList();

        return ListView(
          shrinkWrap: true,
          children: users,
        );
      },
    );
  }
}

Future<void> bookUser({required UserModel userModel}) async {
  final docRef = userCollection.doc();
  UserModel usermodel = UserModel(
      name: userModel.name,
      cpf: userModel.cpf,
      phone: userModel.phone,
      email: userModel.email,
      id: docRef.id);

  await docRef.set(usermodel.toJson()).then(
      (value) => log("User booked successfully!"),
      onError: (e) => log("Error booking user: $e"));
}

Future<void> updateUser(
    {required UserModel userModel, required String userId}) async {
  await userCollection.doc(userId).update(userModel.toJson()).then(
      (value) => log("User updated successfully!"),
      onError: (e) => log("Error updating user: $e"));
  _editForm = false;
  _editApptId = '';
}

void deleteUser(UserModel user) {
  userCollection.doc(user.id).delete().then(
      (value) => log("User deleted successfully!"),
      onError: (e) => log("Error deleting user: $e"));
}
