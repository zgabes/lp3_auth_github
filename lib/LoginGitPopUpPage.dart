import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginGitPopUpPage extends StatelessWidget {
  const LoginGitPopUpPage({super.key});

  void verificarLogin(User? user, BuildContext context) {
    if (user != null) {
      Navigator.pushReplacementNamed(
        context,
        '/explicacao',
        arguments: {"metodo": "popup"},
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Falha no login com GitHub.")),
      );
    }
  }

  void loginGit(BuildContext context) async {
    try {
      GithubAuthProvider githubProvider = GithubAuthProvider();
      final credential =
          await FirebaseAuth.instance.signInWithPopup(githubProvider);
      verificarLogin(credential.user, context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro no login: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(), 
        title: const Text(
          "Login GitHub - Popup",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 6,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => loginGit(context),
          
          child: const Text("Entrar com GitHub (Popup)"),
        ),
      ),
    );
  }
}
