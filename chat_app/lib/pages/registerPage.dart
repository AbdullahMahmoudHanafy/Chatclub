import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/chatPage.dart';
import 'package:scholar_chat/widgets/customButton.dart';
import 'package:scholar_chat/widgets/textField.dart';

class registerPage extends StatefulWidget {
  registerPage({super.key});

  static String id = "RegisterPage";

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
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
                  image: AssetImage(
                    kAppMainImage,
                  ),
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
                      "Register",
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
                        await registerCode();
                        showSnakBar(context, "Success");
                        Navigator.pushNamed(context, chatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnakBar(context, "Weak Password");
                        } else if (e.code == 'email-already-in-use') {
                          showSnakBar(context, "The account already exists");
                        }
                      } catch (e) {
                        showSnakBar(context, "There was an error");
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  title: "Register",
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
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

  Future<void> registerCode() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.displayName);
  }
}
