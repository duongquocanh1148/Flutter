import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_now/service/shared_preference.dart';

import '../pages/home_page.dart';
import '../widget/widget.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool isCheck = false;
  bool showPW = false;
  bool isEmailValidation = true;
  bool isPWValidation = true;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn(String email, String password) async {
    if (isEmailValidation && isPWValidation) {
      try {
        await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          nextScreenRemove(context, const HomePage());
        });       
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, Colors.red, e.message.toString());
      }
    } else {
      showSnackBar(context, Colors.red, "Email or password incorrect!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email",
              prefixIcon: const Icon(Icons.email),
              border: const OutlineInputBorder(),
              errorText: !isEmailValidation ? "Please enter your email!" : null,
            ),
            onChanged: (value) {
              setState(() {
                if (!validateEmail(value)) {
                  isEmailValidation = false;
                } else {
                  isEmailValidation = true;
                }
              });
            },
            onTap: () {
              setState(() {
                if (emailController.text.isEmpty) {
                  isEmailValidation = false;
                }
              });
            },
          ),
          const SizedBox(height: 10),
          TextField(
            controller: passwordController,
            textInputAction: TextInputAction.go,
            obscureText: !showPW,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: const Icon(Icons.lock),
              border: const OutlineInputBorder(),
              errorText: !isPWValidation ? "Please enter your password!" : null,
              suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      showPW = !showPW;
                    });
                  },
                  child: !showPW
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off)),
            ),
            onChanged: (value) {
              setState(() {
                if (passwordController.text.length < 6) {
                  isPWValidation = false;
                } else {
                  isPWValidation = true;
                }
              });
            },
            onTap: () {
              setState(() {
                if (passwordController.text.isEmpty) {
                  isPWValidation = false;
                }
              });
            },
          ),
          Row(
            children: [
              Checkbox(
                  value: isCheck,
                  onChanged: (value) {
                    setState(() {
                      isCheck = !isCheck;
                    });
                  }),
              const Text(
                "Remember me",
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Container(
              // ignore: sort_child_properties_last
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  if (isCheck) {
                    SharedPrefs().setLoginStatus(isCheck);
                  }
                  signIn(emailController.text, passwordController.text);
                },
                child: const Text(
                  "Countinue",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
