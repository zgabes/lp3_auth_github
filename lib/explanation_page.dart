import 'package:flutter/material.dart';

class ExplanationPage extends StatelessWidget {
  const ExplanationPage({super.key});

  Widget buildSection(String title, String method, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '🔹 Método utilizado: $method\n',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explicação Técnica dos Métodos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildSection(
              'Login por Popup',
              'signInWithPopup()',
              '''
Esse método abre uma janela pop-up para autenticação com o GitHub.

✅ Usado em aplicações Flutter Web.

Exemplo:
GithubAuthProvider githubProvider = GithubAuthProvider();
FirebaseAuth.instance.signInWithPopup(githubProvider);

🔧 GithubAuthProvider:
É o provedor do Firebase que encapsula a autenticação com GitHub.
Serve para iniciar o processo de login com os escopos desejados (e-mail, perfil público, etc.).
''',
            ),
            buildSection(
              'Login por Redirect',
              'signInWithRedirect() + getRedirectResult()',
              '''
Esse método redireciona o usuário para o GitHub para login e, após autenticação, retorna à aplicação.

✅ Útil quando popups são bloqueados ou não suportados.

Passos:
1. Chama: signInWithRedirect(GithubAuthProvider());
2. Após retorno, obtém resultado com getRedirectResult();

🔧 GithubAuthProvider:
Funciona igual ao popup, mas usado com fluxo de redirecionamento.

Importante:
✔ Configure corretamente a URL de retorno no GitHub e Firebase.
✔ Verifique o resultado na função initState().
''',
            ),
            buildSection(
              'Login Manual (OAuth)',
              'FlutterWebAuth + GithubAuthProvider.credential(token)',
              '''
Esse método implementa o fluxo OAuth completo de forma manual.

✅ Usado quando se deseja mais controle sobre o processo.

Fluxo:
1. Abre a URL de autorização com FlutterWebAuth.
2. GitHub redireciona para o app (meuapp://callback).
3. App extrai o código da URL.
4. Usa o código para obter um access token.
5. Usa o token no Firebase com GithubAuthProvider.credential(token).

Exemplo:
final result = await FlutterWebAuth.authenticate(...);
final code = Uri.parse(result).queryParameters['code'];
final token = await getTokenFromGitHub(code);
final credential = GithubAuthProvider.credential(token);
await FirebaseAuth.instance.signInWithCredential(credential);

🔧 Necessário configurar:
- client_id e client_secret do GitHub
- URL de callback personalizada
- Permissões do escopo
''',
            ),
          ],
        ),
      ),
    );
  }
}
