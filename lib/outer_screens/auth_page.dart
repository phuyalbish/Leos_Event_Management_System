import 'package:evento/packagelocation.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (FirebaseAuth.instance.currentUser!.email.toString() ==
              "admin@gmail.com") {
            return const AdminNavbar();
          } else if (FirebaseAuth.instance.currentUser!.email
                  .toString()
                  .substring(0, 5) ==
              "club_") {
            return const ClubNavBar();
          } else {
            return const Navbar();
          }
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
