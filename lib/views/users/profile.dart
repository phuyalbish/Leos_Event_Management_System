import 'package:evento/packagelocation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List searchResult = [];
  String emails = FirebaseAuth.instance.currentUser!.email.toString();
  void searchFromFirebase() async {
    final result = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: emails)
        .get();
    if (mounted) {
      setState(() {
        searchResult = result.docs.map((e) => e.data()).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    searchFromFirebase();

    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 1,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchResult.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage('${searchResult[index]['image']}'),
                    radius: 100,
                  ),
                  ListTile(
                    title: Text(searchResult[index]['name']),
                    subtitle: Text(
                        "${searchResult[index]['age']}\n\"${searchResult[index]['description']}\""),
                  ),
                ],
              );
            },
          ),
        ),
        ElevatedButton(
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
      ],
    ));
  }
}