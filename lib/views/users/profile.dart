import 'package:evento/packagelocation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  .collection('Users')
                  .where('email', isEqualTo: emails)
                  .snapshots(),
              builder: ((context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return const Text('Loading...');
                } else {
                  return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Column(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  NetworkImage("${documentSnapshot['image']}"),
                              backgroundColor: Colors.transparent,
                            ),
                            // child: FadeInImage.assetNetwork(
                            //   placeholder: 'assets/images/default_user.jpg',
                            //   image: "${documentSnapshot['image']}",
                            //   width: MediaQuery.of(context).size.width,
                            //   fit: BoxFit.cover,
                            //   height: 200,
                            // ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  documentSnapshot['name'],
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Age: ${documentSnapshot['age']} "),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("${documentSnapshot['description']}"),
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
