import 'package:evento/packagelocation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List searchResult = [];
  // void searchFromFirebase() async {
  //   final result = await FirebaseFirestore.instance.collection('Events').get();

  //   if (mounted) {
  //     setState(() {
  //       searchResult = result.docs.map((e) => e.data()).toList();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // searchFromFirebase();
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.89,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Events').snapshots(),
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
