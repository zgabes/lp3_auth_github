import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginGitRedirectPage extends StatefulWidget {
  const LoginGitRedirectPage({super.key});

  @override
  State<LoginGitRedirectPage> createState() => _LoginGitRedirectPageState();
}

class _LoginGitRedirectPageState extends State<LoginGitRedirectPage> {
  bool _isProcessingLogin = false;
  bool _hasCheckedRedirect = false; // Garante que só verificamos 1x por build

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Executa verificação apenas uma vez, após redirecionamento
    if (!_hasCheckedRedirect) {
      _hasCheckedRedirect = true;
      _checkRedirectResult();
    }
  }

  /// Verifica se há resultado de login após retorno do GitHub
  Future<void> _checkRedirectResult() async {
    try {
      final result = await FirebaseAuth.instance.getRedirectResult();
      debugPrint("Redirect result: ${result.user}");

      if (result.user != null) {
        // Usuário autenticado, navega para tela de explicação
        Navigator.pushReplacementNamed(
          context,
          '/explicacao',
          arguments: {"metodo": "redirect"},
        );
      } else {
        debugPrint("Usuário não retornou autenticado.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao finalizar login: $e")),
      );
    }
  }

  /// Inicia o processo de redirecionamento para login via GitHub
  void _loginGitRedirect() async {
    if (_isProcessingLogin) return;

    setState(() => _isProcessingLogin = true);

    try {
      GithubAuthProvider provider = GithubAuthProvider();
      await FirebaseAuth.instance.signInWithRedirect(provider);

      // O app será pausado aqui, e continuará depois do login no GitHub
    } catch (e) {
      setState(() => _isProcessingLogin = false);
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
          "Login GitHub - Redirect",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 6,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.blueGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _isProcessingLogin ? null : _loginGitRedirect,
          child: Text(
            _isProcessingLogin ? "Processando..." : "Entrar com Redirect",
          ),
        ),
      ),
    );
  }
}
