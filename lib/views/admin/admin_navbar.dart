// ignore_for_file: file_names

import 'package:evento/packagelocation.dart';

class AdminNavbar extends StatefulWidget {
  const AdminNavbar({super.key});

  @override
  State<AdminNavbar> createState() => _AdminNavbarState();
}

class _AdminNavbarState extends State<AdminNavbar> {
  bool isHomePageVisible = true;
  bool isAddPageVisible = false;
  bool isPersonPageVisible = false;
  bool isSearchPageVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 236),
      body: SafeArea(
          child: Stack(
        children: [
          Column(children: [
            Visibility(visible: isHomePageVisible, child: const HomePage()),
            Visibility(visible: isSearchPageVisible, child: const SearchPage()),
            Visibility(visible: isAddPageVisible, child: const AddClubs()),
            Visibility(visible: isPersonPageVisible, child: const PersonPage()),
          ]),
          Positioned(
            bottom: 0,
            left: 0,
            height: MediaQuery.of(context).size.height * 0.075,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GNav(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  activeColor: const Color.fromARGB(255, 255, 255, 255),
                  // tabBackgroundColor: Colors.grey,
                  tabActiveBorder: Border.all(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      width: 1),
                  gap: 8,
                  padding: const EdgeInsets.all(10),
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: "Home",
                      onPressed: () {
                        setState(() {
                          isSearchPageVisible = false;
                          isHomePageVisible = true;
                          isAddPageVisible = false;
                          isPersonPageVisible = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.group_add_rounded,
                      text: "Add Clubs",
                      onPressed: () {
                        setState(() {
                          isSearchPageVisible = false;
                          isHomePageVisible = false;
                          isAddPageVisible = true;
                          isPersonPageVisible = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.search,
                      text: "Search Events",
                      onPressed: () {
                        setState(() {
                          isSearchPageVisible = true;
                          isHomePageVisible = false;
                          isAddPageVisible = false;
                          isPersonPageVisible = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.person_search,
                      text: "Members",
                      onPressed: () {
                        setState(() {
                          isSearchPageVisible = false;
                          isHomePageVisible = false;
                          isAddPageVisible = false;
                          isPersonPageVisible = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
