import 'package:flutter/material.dart';
import 'package:todolist/LoginGitManualPage.dart';
import 'package:todolist/LoginGitPopUpPage.dart';
import 'package:todolist/LoginGitRedirectPage.dart';
import 'package:todolist/explanation_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: const Icon(Icons.login_rounded),
        centerTitle: true,
        elevation: 6,
        title: const Text(
          'TRABALHO DE LP3 - Métodos de Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1.2,
          ),
        ),
  
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLoginButton(
              context,
              icon: Icons.login,
              color: Colors.deepPurple,
              label: 'Login com GitHub (PopUp)',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginGitPopUpPage()),
              ),
            ),
            const SizedBox(height: 16),
            buildLoginButton(
              context,
              icon: Icons.redo,
              color: Colors.teal,
              label: 'Login com GitHub (Redirect)',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginGitRedirectPage()),
              ),
            ),
            const SizedBox(height: 16),
            buildLoginButton(
              context,
              icon: Icons.key,
              color: Colors.orange,
              label: 'Login com GitHub (Manual OAuth)',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginGitManualPage()),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.info_outline),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              label: const Text('Explicações Técnicas'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ExplanationPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoginButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 24),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      onPressed: onPressed,
    );
  }
}
