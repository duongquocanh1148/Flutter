
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_now/models/user.dart';
import '../service/shared_preference.dart';
import '../widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

double height = 10;



class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cfpassController = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool showPW = false;
  bool showCfpass = false;
  bool isEmailValidation = true;
  bool isPWValidation = true;
  bool isNameValidation = true;
  bool isConPassValidation = true;

  String id = "";
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  Future<void> register() async {
    if (isEmailValidation &&
        isNameValidation &&
        isPWValidation &&
        isConPassValidation) {
      if (passwordController.text == cfpassController.text) {
        try {
          await firebaseAuth
              .createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) {
            setState(() {
              id = value.user!.uid;             
            });
          });
          
          Map<String, dynamic> map = {
            'userID': id,
            'email': emailController.text,
            'password': passwordController.text,
            'userName': nameController.text,
            'mobile': "",
            'address': "",
          };
          SharedPrefs sharedPrefs = SharedPrefs();
          //sharedPrefs.saveUser(map);
         
          FirebaseDatabase.instance
              .ref('users')
              .child(map['userID'])
              .set(map)
              .then((value) {
            showSnackBar(context, Colors.blue, "Register successfully");
            Navigator.pop(context);
          });
        } on FirebaseAuthException catch (e) {
          showSnackBar(context, Colors.red, e.message.toString());
        }
      } else {
        showSnackBar(context, Colors.red, "Password does not match");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(children: [
          SizedBox(height: 5 * height),
          const Text("Register Account",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: height),
          const Text(
            "Complete your details or countinue \n with social media",
            style: TextStyle(color: Colors.green),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height),
          TextField(
            controller: nameController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: "User Name",
                suffixIcon: const Icon(Icons.account_box),
                border: const OutlineInputBorder(),
                errorText:
                    !isNameValidation ? "Please enter your user name!" : null),
            onChanged: (value) {
              if (value.isEmpty) {
                isEmailValidation = true;
              } else {
                isEmailValidation = false;
              }
            },
          ),
          SizedBox(height: height),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Email",
              suffixIcon: const Icon(Icons.email),
              border: const OutlineInputBorder(),
              errorText:
                  !isEmailValidation ? "Please enter correct email!" : null,
            ),
            onChanged: (value) {
              setState(() {
                if (validateEmail(value)) {
                  isEmailValidation = true;
                } else {
                  isEmailValidation = false;
                }
              });
            },
          ),
          SizedBox(height: height),
          TextField(
            controller: passwordController,
            obscureText: !showPW,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Password",
              errorText: !isPWValidation ? "Please enter your password!" : null,
              border: const OutlineInputBorder(),
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
          ),
          SizedBox(height: height),
          TextField(
            controller: cfpassController,
            obscureText: !showCfpass,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
                hintText: "Confirm Password",
                border: const OutlineInputBorder(),
                errorText: !isConPassValidation
                    ? "Please enter your confirm password!"
                    : null,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      showCfpass = !showCfpass;
                    });
                  },
                  child: !showCfpass
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                )),
            onChanged: (value) {
              setState(() {
                if (cfpassController.text.length < 6) {
                  isConPassValidation = false;
                } else {
                  isConPassValidation = true;
                }
              });
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Container(
              // ignore: sort_child_properties_last
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  register();
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("asset/svg/facebook.svg"),
              const SizedBox(width: 10),
              SvgPicture.asset("asset/svg/google.svg"),
              const SizedBox(width: 10),
              SvgPicture.asset("asset/svg/twitter.svg"),
            ],
          ),
        ]),
      ),
    );
  }

  
}


  

