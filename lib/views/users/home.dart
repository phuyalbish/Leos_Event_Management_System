import 'package:evento/packagelocation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List searchResult = [];
  void searchFromFirebase() async {
    final result = await FirebaseFirestore.instance.collection('Events').get();

    if (mounted) {
      setState(() {
        searchResult = result.docs.map((e) => e.data()).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    searchFromFirebase();
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.89,
        child: ListView.builder(
          itemCount: searchResult.length,
          itemBuilder: (context, index) {
            return EventPost(
              eventaddress: searchResult[index]['Address'],
              eventorgby: searchResult[index]['Organizedby'],
              eventorgbyimg: searchResult[index]['Organizedbyimg'],
              eventorgbyemail: searchResult[index]['Organizedbyemail'],
              eventpostname: searchResult[index]['Title'],
              eventscheduleddate: searchResult[index]['Scheduleddate'],
              eventpostdate: searchResult[index]['Postdate'],
            );
          },
        ),
      ),
    );
  }
}
