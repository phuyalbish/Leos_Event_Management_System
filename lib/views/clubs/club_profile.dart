import 'package:evento/packagelocation.dart';

class ClubProfile extends StatefulWidget {
  const ClubProfile({super.key});

  @override
  State<ClubProfile> createState() => _ClubProfileState();
}

class _ClubProfileState extends State<ClubProfile> {
  List searchResult = [];
  String emails = FirebaseAuth.instance.currentUser!.email.toString();
  void searchFromFirebase() async {
    final result = await FirebaseFirestore.instance
        .collection('Clubs')
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 1,
              child: ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Image.network("${searchResult[index]['image']}"),
                            Text(
                              searchResult[index]['name'],
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("${searchResult[index]['email']} "),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${searchResult[index]['description']}",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                "president: ${searchResult[index]['president']}"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("address: ${searchResult[index]['addredd']}"),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            child: const Text("Edit Club"),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              });
            },
          ),
          ElevatedButton(
            child: const Text("Delete Club"),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              });
            },
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
      )),
    );
  }
}
