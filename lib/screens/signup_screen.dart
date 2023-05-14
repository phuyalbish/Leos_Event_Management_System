// ignore_for_file: library_private_types_in_public_api, unused_catch_clause

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evento/packagelocation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _retypepasswordTextController =
      TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _ageTextController = TextEditingController();

  final fireStore = FirebaseFirestore.instance.collection('Users');
  String errorMsg = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter UserName", Icons.person_outline, false,
                  _userNameTextController,
                  txttype: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Email Id", Icons.person_outline, false,
                  _emailTextController,
                  txttype: TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter age", Icons.timelapse_outlined, false,
                  _ageTextController,
                  txttype: TextInputType.number),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Password", Icons.lock_outlined, true,
                  _passwordTextController,
                  txttype: TextInputType.visiblePassword),
              const SizedBox(
                height: 20,
              ),
              reusableTextField(
                  "ReType Password",
                  Icons.lock_outlined,
                  true,
                  txttype: TextInputType.visiblePassword,
                  _retypepasswordTextController),
              const SizedBox(
                height: 20,
              ),
              firebaseUIButton(context, "Sign Up", () async {
                if (_retypepasswordTextController.text ==
                    _passwordTextController.text) {
                  try {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      fireStore.doc().set({
                        'age': _ageTextController.text,
                        'email': _emailTextController.text,
                        'name': _userNameTextController.text,
                      }).then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Navbar()));
                      }).onError((error, stackTrace) {
                        setState(() {
                          errorMsg = "something wrong.";
                        });
                      });
                    });
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      errorMsg = "Invalid Username or Password";
                    });
                  }
                } else {
                  setState(() {
                    errorMsg = "Password didn't match.";
                  });
                }
              }),
              const SizedBox(
                height: 5,
              ),
              Text(errorMsg),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
