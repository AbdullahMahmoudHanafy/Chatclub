import 'package:flutter/material.dart';
import 'package:scholar_chat/pages/chatPage.dart';
import 'package:scholar_chat/pages/loginPage.dart';
import 'package:scholar_chat/pages/registerPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        loginPage.id: (context) => loginPage(),
        registerPage.id: (context) => registerPage(),
        chatPage.id: (context) => chatPage(),
      },
      initialRoute: loginPage.id,
    );
  }
}
