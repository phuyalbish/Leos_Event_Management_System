import 'package:evento/packagelocation.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.91,
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
              const SizedBox(height: 20),
              const Text(
                "Clubs:",
                style: TextStyle(fontSize: 20),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Clubs')
                        .snapshots(),
                    builder: ((context,
                        AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (!streamSnapshot.hasData)
                        return const Text('Loading...');
                      return ListView.builder(
                        itemCount: streamSnapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return buildClub(context, documentSnapshot);
                          // return Text(documentSnapshot["name"]);
                        },
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
