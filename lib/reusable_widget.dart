import 'package:evento/packagelocation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller,
    {TextInputType txttype = TextInputType.text}) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    keyboardType: txttype,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color.fromARGB(255, 150, 68, 243);
            }
            return const Color.fromARGB(255, 150, 68, 243);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Color.fromARGB(221, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
    ),
  );
}

// class EventPost extends StatefulWidget {
//   // final String? eventpostname;
//   // final String? eventorgby;
//   // final String? eventaddress;
//   // final String? eventpostimage;
//   // final String? eventorgbyemail;
//   // final String? eventorgbyimg;
//   // final String? eventscheduleddate;
//   // final String? eventpostdate;
//   // final int? eventpostvote;
//   const EventPost(
//       //     {super.key,
//       //     this.eventaddress,
//       //     this.eventorgby,
//       //     this.eventpostname,
//       //     this.eventpostimage,
//       //     this.eventorgbyimg,
//       //     this.eventorgbyemail,
//       //     this.eventscheduleddate,
//       //     this.eventpostdate,
//       //     this.eventpostvote,}

//       BuildContext context,
//       DocumentSnapshot document);

//   @override
//   State<EventPost> createState() => _EventPostState();
// }

// class _EventPostState extends State<EventPost> {

Widget buildEvent(BuildContext context, DocumentSnapshot document) {
  String curEmails = FirebaseAuth.instance.currentUser!.email.toString();
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
    child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 20),
        // padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19),
                topRight: Radius.circular(19),
              ),
              child: Image.network(
                "${document['Image']}",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            const SizedBox(height: 2),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "${document['Organizedbyimg']}",
                      width: 60,
                      fit: BoxFit.cover,
                      height: 60,
                    ),
                  ),
                  title: Text(document['Title']),
                  subtitle: Row(
                    children: [
                      Text(
                        document['Organizedby'],
                        style: const TextStyle(
                            color: Color.fromARGB(255, 48, 48, 48)),
                      ),
                      const Text("  "),
                      Text(
                        convertToAgo(document['Postdate']),
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      int count = 0;
                      List voterslist = [curEmails];
                      for (var name in document["Voters"]) {
                        if (name == curEmails) {
                          count = count + 1;
                          break;
                        }
                      }
                      if (count == 1) {
                        document.reference
                            .update({'Votes': document['Votes'] - 1});
                      } else {
                        document.reference.update(
                            {'Voters': FieldValue.arrayUnion(voterslist)});
                        document.reference
                            .update({'Votes': document['Votes'] + 1});
                      }
                    },
                    child: SizedBox(
                      width: 55,
                      height: 40,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, right: 5),
                            child: Text(
                              "${document['Votes']}",
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          const Icon(Icons.volunteer_activism_sharp),
                        ],
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 10),
          ],
        )),
  );
}
// }

String convertToAgo(String dateTimestr) {
  DateTime dateTime =
      DateFormat('yyyy-MM-DD HH:mm:ss.SSSSSSZ').parse(dateTimestr, true);
  DateTime now = DateTime.now().toLocal();

  DateTime localDateTime = dateTime.toLocal();

  if (localDateTime.difference(now).inDays == 0) {
    var differenceInHours = localDateTime.difference(now).inHours.abs();
    var differenceInMins = localDateTime.difference(now).inMinutes.abs();

    if (differenceInHours > 0) {
      return '$differenceInHours hours ago';
    } else if (differenceInMins > 2) {
      return '$differenceInMins mins ago';
    } else {
      return 'Just now';
    }
  }

  String roughTimeString = DateFormat('jm').format(dateTime);

  if (localDateTime.day == now.day &&
      localDateTime.month == now.month &&
      localDateTime.year == now.year) {
    return roughTimeString;
  }

  DateTime yesterday = now.subtract(const Duration(days: 1));

  if (localDateTime.day == yesterday.day &&
      localDateTime.month == now.month &&
      localDateTime.year == now.year) {
    return 'Yesterday';
  }

  if (now.difference(localDateTime).inDays < 4) {
    String weekday = DateFormat(
      'EEEE',
    ).format(localDateTime);

    return '$weekday, $roughTimeString';
  }

  return DateFormat('yMd').format(dateTime);
}

class EventPostSearch extends StatefulWidget {
  final String? eventpostname;
  final String? eventorgby;
  final String? eventaddress;
  final String? eventpostimage;
  final String? eventorgbyemail;
  final String? eventorgbyimg;
  final String? eventscheduleddate;
  final String? eventpostdate;
  final int? eventpostvote;
  const EventPostSearch({
    super.key,
    this.eventaddress,
    this.eventorgby,
    this.eventpostname,
    this.eventpostimage,
    this.eventorgbyimg,
    this.eventorgbyemail,
    this.eventscheduleddate,
    this.eventpostdate,
    this.eventpostvote,
  });

  @override
  State<EventPostSearch> createState() => _EventPostSearchState();
}

class _EventPostSearchState extends State<EventPostSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 20),
          // padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(19),
                  topRight: Radius.circular(19),
                ),
                child: Image.network(
                  "${widget.eventpostimage}",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "${widget.eventorgbyimg}",
                        width: 60,
                        fit: BoxFit.cover,
                        height: 60,
                      ),
                    ),
                    title: Text(widget.eventpostname!),
                    subtitle: Row(
                      children: [
                        Text(
                          widget.eventorgby!,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 48, 48, 48)),
                        ),
                        const Text("  "),
                        Text(
                          convertToAgo(widget.eventpostdate!),
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    // trailing: ElevatedButton(
                    //   onPressed: () {
                    //     document.reference
                    //         .update({'Votes': document['Votes'] + 1});
                    //   },
                    //   child: SizedBox(
                    //     width: 40,
                    //     height: 40,
                    //     child: Row(
                    //       children: [
                    //         Padding(
                    //           padding:
                    //               const EdgeInsets.only(top: 8.0, right: 5),
                    //           child: Text(
                    //             "${document['Votes']}",
                    //             style: const TextStyle(fontSize: 15),
                    //           ),
                    //         ),
                    //         const Icon(Icons.volunteer_activism_sharp),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  )),
              const SizedBox(height: 10),
            ],
          )),
    );
  }
}
