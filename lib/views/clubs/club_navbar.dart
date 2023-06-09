import 'package:evento/packagelocation.dart';

class ClubNavBar extends StatefulWidget {
  const ClubNavBar({super.key});

  @override
  State<ClubNavBar> createState() => _ClubNavBarState();
}

class _ClubNavBarState extends State<ClubNavBar> {
  bool isHomePageVisible = true;

  bool isAddPageVisible = false;

  bool isPersonPageVisible = false;

  bool isSearchPageVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(children: [
            Visibility(visible: isHomePageVisible, child: const HomePage()),
            Visibility(visible: isSearchPageVisible, child: const SearchPage()),
            Visibility(visible: isAddPageVisible, child: const AddEvent()),
            Visibility(
                visible: isPersonPageVisible, child: const ClubProfile()),
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
                      icon: Icons.event,
                      text: "Add Events",
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
                      icon: Icons.group,
                      text: "Club Profile",
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
