import 'package:evento/packagelocation.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool isHomePageVisible = true;
  bool isSearchPageVisible = false;
  bool isProfilePageVisible = false;
  bool isWishlistPageVisible = false;
  bool isTopPageVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(children: [
            Visibility(visible: isHomePageVisible, child: const HomePage()),
            Visibility(visible: isSearchPageVisible, child: const SearchPage()),
            Visibility(
                visible: isWishlistPageVisible, child: const SavedPage()),
            Visibility(
                visible: isProfilePageVisible, child: const ProfilePage()),
            Visibility(visible: isTopPageVisible, child: const TopPage()),
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
                          isHomePageVisible = true;
                          isSearchPageVisible = false;
                          isProfilePageVisible = false;
                          isWishlistPageVisible = false;
                          isTopPageVisible = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.volunteer_activism_sharp,
                      text: "Volunter",
                      onPressed: () {
                        setState(() {
                          isWishlistPageVisible = true;
                          isSearchPageVisible = false;
                          isHomePageVisible = false;
                          isProfilePageVisible = false;
                          isTopPageVisible = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.search,
                      text: "Search",
                      onPressed: () {
                        setState(() {
                          isSearchPageVisible = true;
                          isHomePageVisible = false;
                          isProfilePageVisible = false;
                          isWishlistPageVisible = false;
                          isTopPageVisible = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.person,
                      text: "Profile",
                      onPressed: () {
                        setState(() {
                          isSearchPageVisible = false;
                          isHomePageVisible = false;
                          isProfilePageVisible = true;
                          isWishlistPageVisible = false;
                          isTopPageVisible = false;
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
