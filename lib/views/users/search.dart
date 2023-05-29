import 'package:evento/packagelocation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List searchResult = [];
  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('Events')
        .where('Title_id_Array', arrayContains: query.toUpperCase())
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
              }),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.785,
            child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                return EventPost(
                  eventaddress: searchResult[index]['Address'],
                  eventorgby: searchResult[index]['Organizedby'],
                  eventpostname: searchResult[index]['Title'],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
