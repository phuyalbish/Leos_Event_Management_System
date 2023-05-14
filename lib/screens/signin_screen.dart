// ignore_for_file: library_private_types_in_public_api, unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';

import 'package:evento/packagelocation.dart';
// import 'package:evento/screens/home_screen.dart';
// import 'package:evento/screens/reset_password.dart';
// import 'package:evento/screens/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  String errorMsg = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('assets/images/profile.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Lions Club of Kathmandu",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Roar For More",
                        style: TextStyle(color: Colors.blue, fontSize: 18)),
                  ]),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      40, MediaQuery.of(context).size.height * 0.35, 40, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      reusableTextField("Enter Email", Icons.person_outline,
                          false, _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter Password", Icons.lock_outline,
                          true, _passwordTextController),
                      const SizedBox(
                        height: 5,
                      ),
                      forgetPassword(context),
                      // firebaseUIButton(context, "Sign In", () {
                      //   FirebaseAuth.instance
                      //       .signInWithEmailAndPassword(
                      //           email: _emailTextController.text,
                      //           password: _passwordTextController.text)
                      //       .then((value) {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => const Navbar()));
                      //   }).onError((error, stackTrace) {
                      //     print("Error ${error.toString()}");
                      //   });
                      // }),

                      firebaseUIButton(context, "Sign In", () async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text)
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Navbar())));
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            errorMsg = "Invalid Username or Password";
                          });
                        }
                      }),
                      Text(errorMsg),
                      const SizedBox(
                        height: 5,
                      ),
                      signUpOption()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}

// String _signIncheck(String emailx, String passwordx, BuildContext context) {
//   String errormsg;
//   void signIn(String emailx, String passwordx, BuildContext context) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: emailx, password: passwordx)
//           .then((value) => Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const Navbar())));
//     } on FirebaseAuthException catch (e) {
//       errormsg = "Invalid Username/Password";
//     }
//   }

//   signIn(emailx, passwordx, context);

//   return errormsg;
// }
