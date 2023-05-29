import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evento/packagelocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

class AddClubs extends StatefulWidget {
  const AddClubs({super.key});

  @override
  State<AddClubs> createState() => _AddClubsState();
}

class _AddClubsState extends State<AddClubs> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _retypepasswordTextController =
      TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _clubNameTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  final TextEditingController _descTextController = TextEditingController();
  final TextEditingController _presidentTextController =
      TextEditingController();
  String imageUrl = '';
  final fireStore = FirebaseFirestore.instance.collection('Clubs');
  String errorMsg = "";
  String imagemsg = "";

  @override
  Widget build(BuildContext context) {
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
                            width: 2, // the thickness
                            color: Color.fromARGB(
                                255, 140, 79, 255) // the color of the border
                            )),
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
                reusableTextField("Enter Club Name", Icons.group, false,
                    _clubNameTextController,
                    txttype: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField(
                    "Enter Email Id", Icons.email, false, _emailTextController,
                    txttype: TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField("Enter Club Addredd", Icons.map, false,
                    _addressTextController,
                    txttype: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField("Enter Club President Name", Icons.person,
                    false, _presidentTextController,
                    txttype: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField("Type Club Description", Icons.description,
                    false, _descTextController,
                    txttype: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField("Enter Password For Club",
                    Icons.lock_outlined, true, _passwordTextController,
                    txttype: TextInputType.visiblePassword),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField(
                    "ReType Password For Club",
                    Icons.lock_outlined,
                    true,
                    txttype: TextInputType.visiblePassword,
                    _retypepasswordTextController),
                const SizedBox(
                  height: 10,
                ),
                firebaseUIButton(context, "Create Club", () async {
                  String clubname = _clubNameTextController.text.trim();
                  String email = _emailTextController.text.trim();
                  String desc = _descTextController.text.trim();
                  String pass = _passwordTextController.text.trim();
                  String address = _addressTextController.text.trim();
                  String president = _presidentTextController.text.trim();
                  if (clubname.length > 4 &&
                      pass.length > 6 &&
                      desc.length > 4 &&
                      president.length > 4) {
                    if (_retypepasswordTextController.text ==
                        _passwordTextController.text) {
                      if (imageUrl.isNotEmpty) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: "club_$email", password: pass)
                              .then((value) {
                            fireStore.doc().set({
                              'email': "club_$email",
                              'name': clubname,
                              'addredd': address,
                              'description': desc,
                              'image': imageUrl,
                              'president': president,
                            }).then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminNavbar()));
                            }).onError((error, stackTrace) {
                              setState(() {
                                errorMsg = "something wrong.";
                              });
                            });
                          });
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            errorMsg = "Invalid User Email or Password";
                          });
                        }
                      } else {
                        setState(() {
                          errorMsg = "Please upload an image";
                        });
                      }
                    } else {
                      setState(() {
                        errorMsg = "Password didn't match.";
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
