import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolist/LoginGitManualPage.dart';
import 'package:todolist/LoginGitPopUpPage.dart';
import 'package:todolist/LoginGitRedirectPage.dart';
import 'package:todolist/explanation_page.dart';
import 'package:todolist/login_page.dart';


const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyDQvNUL3AHjjWd8Pav3QJCvYMfkkzE__-o",
  authDomain: "todolist-365c1.firebaseapp.com",
  projectId: "todolist-365c1",
  storageBucket: "todolist-365c1.appspot.com",
  messagingSenderId: "957459935188",
  appId: "1:957459935188:web:45baed17354d6e2aa0b041",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trabalho LP3',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/LoginPage',
      routes: {
        '/LoginPage': (context) =>  const LoginPage(), 
        '/loginPopup': (context) =>  const LoginGitPopUpPage(),
        '/loginRedirect': (context) => const LoginGitRedirectPage(),
        '/loginManual': (context) =>  const LoginGitManualPage(),
        '/explicacao': (context) => const ExplanationPage(),
      },
    );
  }
}




