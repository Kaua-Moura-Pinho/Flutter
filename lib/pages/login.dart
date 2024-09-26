import 'package:apploja/pages/user_details.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x7500FFFF),
        centerTitle: true,
        title: const Text("Lojas 1.000"),
      ),
      // Use Stack para colocar a imagem de fundo
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'img2.png'), // Certifique-se de que o caminho está correto no pubspec.yaml
                fit: BoxFit.cover,
              ),
            ),
            height: double.infinity,
            width: double.infinity,
          ),
          // Conteúdo do login
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 500.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 24.0,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1.5
                      ..color = const Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(height: 30.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserHomePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50.0,
                    width: 500.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00FFFF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF000000),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Usuário",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 2, 2, 2)
                          ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
