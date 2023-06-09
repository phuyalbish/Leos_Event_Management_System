import 'package:evento/packagelocation.dart';

class ClubProfile extends StatefulWidget {
  const ClubProfile({super.key});

  @override
  State<ClubProfile> createState() => _ClubProfileState();
}

class _ClubProfileState extends State<ClubProfile> {
  @override
  Widget build(BuildContext context) {
    String emails = FirebaseAuth.instance.currentUser!.email.toString();

    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 1,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Clubs')
                  .where('email', isEqualTo: emails)
                  .snapshots(),
              builder: ((context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return const Text('Loading...');
                } else {
                  return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      // final DocumentSnapshot documentSnapshot =
                      //     streamSnapshot.data!.docs[index];
                      return Column(
                        children: [
                          // Container(
                          //   width: 200,
                          //   height: 200,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //   ),
                          //   child: FadeInImage.assetNetwork(
                          //     placeholder: 'assets/images/default_club.png',
                          //     image: "${documentSnapshot['image']}",
                          //     width: MediaQuery.of(context).size.width,
                          //     fit: BoxFit.cover,
                          //     height: 200,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  streamSnapshot.data!.docs[index]['name'],
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "${streamSnapshot.data!.docs[index]['email']} "),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "${streamSnapshot.data!.docs[index]['description']}"),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "president: ${streamSnapshot.data!.docs[index]['president']}"),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "address: ${streamSnapshot.data!.docs[index]['address']}"),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }),
            ),
          ),
        ),
        ElevatedButton(
          child: const Text("Edit Account"),
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
          child: const Text("Delete Account"),
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
    ));
  }
}
