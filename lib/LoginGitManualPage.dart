import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class LoginGitManualPage extends StatelessWidget {
  // Somente o clientId pode estar no app, o clientSecret deve ficar no backend seguro.
  final String clientId = 'Ov23libAtqGlODtJ7rXh';
  final String redirectUri = 'https://todolist-365c1.firebaseapp.com/__/auth/handler';

  const LoginGitManualPage({super.key});

  void verificarLogin(User? user, BuildContext context) {
    if (user != null) {
      Navigator.pushReplacementNamed(
        context,
        '/explicacao',
        arguments: {"metodo": "manual"},
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Falha no login com GitHub.")),
      );
    }
  }

  Future<void> loginGitManual(BuildContext context) async {
    try {
      // Passo 1: redireciona o usuário para autorizar o app no GitHub
      final result = await FlutterWebAuth.authenticate(
        url:
            'https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=read:user user:email',
        callbackUrlScheme: 'https',
      );

      // Passo 2: extrai o code da URL de retorno
      final code = Uri.parse(result).queryParameters['code'];

      // Passo 3: Envia o código para seu backend seguro
      final tokenResponse = await http.post(
        Uri.parse('https://SEU_BACKEND/token'), // Substitua pela URL da sua API
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'code': code}),
      );

      if (tokenResponse.statusCode != 200) {
        throw Exception('Erro ao obter token do servidor: ${tokenResponse.body}');
      }

      final accessToken = jsonDecode(tokenResponse.body)['access_token'];

      // Passo 4: Usa o access token para autenticar no Firebase
      final credential = GithubAuthProvider.credential(accessToken);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      verificarLogin(userCredential.user, context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro inesperado: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Login GitHub - Manual OAuth",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 6,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => loginGitManual(context),
          child: const Text("Entrar com GitHub (Manual OAuth)"),
        ),
      ),
    );
  }
}
