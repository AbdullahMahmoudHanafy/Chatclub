import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/chatPage.dart';
import 'package:scholar_chat/pages/registerPage.dart';
import 'package:scholar_chat/widgets/customButton.dart';
import 'package:scholar_chat/widgets/textField.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  static String id = "LoginPage";

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 75,
                ),
                Image(
                  image: AssetImage(kAppMainImage),
                  height: 100,
                ),
                Center(
                  child: Text(
                    "Scholars Chat",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Pacifico",
                        fontSize: 32),
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                Row(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                customFormTextField(
                  hidden: false,
                  hintText: "Email",
                  onchanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                customFormTextField(
                  hidden: true,
                  hintText: "Password",
                  onchanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                customButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginCode();
                        showSnakBar(context, "Success");
                        Navigator.pushNamed(context, chatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          // ignore: use_build_context_synchronously
                          showSnakBar(context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          // ignore: use_build_context_synchronously
                          showSnakBar(context,
                              'Wrong password provided for that user.');
                        }
                      } catch (e) {
                        print("There was an error");
                        showSnakBar(context, "There was an error");
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  title: "Login",
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, registerPage.id);
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnakBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> loginCode() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    print(user.user!.displayName);
  }
}
