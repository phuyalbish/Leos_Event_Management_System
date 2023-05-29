import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evento/packagelocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController _eventtitleTextController =
      TextEditingController();
  final TextEditingController _eventaddressTextController =
      TextEditingController();
  final TextEditingController _eventdescTextController =
      TextEditingController();
  final TextEditingController _venueTextController = TextEditingController();
  final TextEditingController _scheduleddateTextController =
      TextEditingController();
  String imageUrl = "";
  final fireStore = FirebaseFirestore.instance.collection('Events');
  String errorMsg = "";
  String imagemsg = "";

  List searchResult = [];
  String clubname = "";
  String clubimg = "";
  String clubemail = "";
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
    return SingleChildScrollView(
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.89,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                        side: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 140, 79, 255))),
                  ),
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();

                    XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery);

                    if (file == null) return;
                    String uniqueImagename =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueImagename);

                    try {
                      await referenceImageToUpload.putFile(File(file.path));
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      //
                    }
                    setState(() {
                      imagemsg = "Image Uploaded";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/Usr_profile2.png'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        Icons.add,
                        size: 50,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  imagemsg,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField("Enter Event Title", Icons.event, false,
                    _eventtitleTextController,
                    txttype: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Type Event Description", Icons.description,
                    false, _eventdescTextController,
                    txttype: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Event Addredd", Icons.map, false,
                    _eventaddressTextController,
                    txttype: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Event Venue", Icons.pin_drop, false,
                    _venueTextController,
                    txttype: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.group,
                          color: Colors.white70,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ListView.builder(
                            itemCount: searchResult.length,
                            itemBuilder: (context, index) {
                              clubname = searchResult[index]['name'];
                              clubimg = searchResult[index]['image'];
                              clubemail = searchResult[index]['email'];
                              return Text(
                                clubname,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white70),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width / 3,
                    child: Center(
                        child: TextField(
                      controller: _scheduleddateTextController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Enter Event Date"),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            _scheduleddateTextController.text = formattedDate;
                          });
                        } else {}
                      },
                    ))),
                firebaseUIButton(context, "Add  Event", () async {
                  String title = _eventtitleTextController.text.trim();
                  String desc = _eventdescTextController.text.trim();
                  String address = _eventaddressTextController.text.trim();
                  String venue = _venueTextController.text.trim();

                  List wordsnum = title.split(" ");
                  List<String> arrayoftitle = [];
                  for (int i = 1; i <= title.length; i++) {
                    arrayoftitle.add(title.substring(0, i).toUpperCase());
                  }
                  for (var j = 1; j < wordsnum.length; j++) {
                    arrayoftitle.add(wordsnum[j].toUpperCase());
                  }
                  if (title.length > 4 &&
                      desc.length > 4 &&
                      address.length > 4 &&
                      venue.length > 4 &&
                      _scheduleddateTextController.text != "") {
                    if (imageUrl.isNotEmpty) {
                      _eventtitleTextController.text = "";
                      _eventdescTextController.text = "";
                      _eventaddressTextController.text = "";
                      fireStore.doc().set({
                        'Title': title,
                        'Address': address,
                        'Description': desc,
                        'Venue': venue,
                        'Scheduleddate': _scheduleddateTextController.text,
                        'Postdate': DateTime.now().toString(),
                        'Title_id_Array': arrayoftitle,
                        'Organizedby': clubname,
                        'Organizedbyimg': clubimg,
                        'Organizedbyemail': clubemail,
                        'Image': imageUrl,
                        'Votes': 0,
                      }).then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ClubNavBar()));
                      }).onError((error, stackTrace) {
                        setState(() {
                          errorMsg = "something wrong.";
                        });
                      });
                    } else {
                      setState(() {
                        errorMsg = "Please upload an image";
                      });
                    }
                  } else {
                    setState(() {
                      errorMsg =
                          "Min Length for Name and Des should be 4 and Pass should be 6 characters";
                    });
                  }
                }),
                const SizedBox(
                  height: 5,
                ),
                Text(errorMsg),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )),
    );
  }
}
