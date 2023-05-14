import 'package:evento/packagelocation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List searchResult = [];
  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('Events')
        .where('Title_id_Array', arrayContains: query)
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Search Here",
            ),
            onChanged: (query) {
              searchFromFirebase(query);
            },
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: searchResult.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchResult[index]['Description']),
                subtitle: Text(searchResult[index]['Organizedby']),
              );
            },
          ),
        ),
      ],
    );
  }
}
