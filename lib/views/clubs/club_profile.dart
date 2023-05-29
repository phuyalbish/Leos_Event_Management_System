import 'package:evento/packagelocation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClubProfile extends StatefulWidget {
  const ClubProfile({super.key});

  @override
  State<ClubProfile> createState() => _ClubProfileState();
}

class _ClubProfileState extends State<ClubProfile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  child: const Text("Logout"),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}