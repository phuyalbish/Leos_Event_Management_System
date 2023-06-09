// ignore_for_file: library_private_types_in_public_api, unused_catch_clause

import 'package:evento/packagelocation.dart';

class AdminSignIn extends StatefulWidget {
  const AdminSignIn({super.key});

  @override
  State<AdminSignIn> createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
                      reusableTextField("Enter Email", Icons.email, false,
                          _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter Password", Icons.lock_outline,
                          true, _passwordTextController),
                      const SizedBox(
                        height: 5,
                      ),
                      firebaseUIButton(context, "Sign In as Club", () async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email:
                                      "club_${_emailTextController.text.trim()}",
                                  password: _passwordTextController.text.trim())
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ClubNavBar())));
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
                      GestureDetector(
                        onTap: () async {
                          if (_emailTextController.text.trim() ==
                              'admin@gmail.com') {}
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _emailTextController.text.trim(),
                                    password:
                                        _passwordTextController.text.trim())
                                .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminNavbar())));
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              errorMsg = "Invalid Username or Password.";
                            });
                          }
                        },
                        child: const Text(
                          "Signup as Admin",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
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
}
