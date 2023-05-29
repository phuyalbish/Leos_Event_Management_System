import 'package:evento/packagelocation.dart';

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

class EventPost extends StatefulWidget {
  final String? eventpostname;
  final String? eventorgby;
  final String? eventaddress;
  final String? eventpostimage;
  final String? eventorgbyemail;
  final String? eventorgbyimg;
  final String? eventscheduleddate;
  final String? eventpostdate;
  const EventPost(
      {super.key,
      this.eventaddress,
      this.eventorgby,
      this.eventpostname,
      this.eventpostimage,
      this.eventorgbyimg,
      this.eventorgbyemail,
      this.eventscheduleddate,
      this.eventpostdate});

  @override
  State<EventPost> createState() => _EventPostState();
}

class _EventPostState extends State<EventPost> {
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
                    title:
                        Text("${widget.eventorgby!}\n${widget.eventpostname!}"),
                    subtitle: Row(
                      children: [
                        Text(widget.eventscheduleddate!),
                        const SizedBox(width: 5),
                        Container(
                          // height: 20,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.eventaddress!,
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: const ListTile(
                        leading: Icon(Icons.details),
                        title: Text("Details"),
                      ),
                    ),
                  )),
              const SizedBox(height: 10),
            ],
          )),
    );
  }
}
