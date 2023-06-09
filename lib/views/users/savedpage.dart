import 'package:evento/packagelocation.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    String emails = FirebaseAuth.instance.currentUser!.email.toString();
    // searchFromFirebase();
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.89,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Events')
              .where('Voters', arrayContains: emails)
              .snapshots(),
          builder: ((context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (!streamSnapshot.hasData) return const Text('Loading...');
            return ListView.builder(
              itemCount: streamSnapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return buildEvent(context, documentSnapshot);
              },
            );
          }),
        ),
      ),
    );
  }
}
