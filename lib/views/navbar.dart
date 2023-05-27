// ignore_for_file: file_names

import 'package:evento/packagelocation.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool isHomePageVisible = true;
  bool isNotificationPageVisible = false;
  bool isProfilePageVisible = false;
  bool isWishlistPageVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(children: [
            Visibility(visible: isHomePageVisible, child: const HomePage()),
            Visibility(
                visible: isNotificationPageVisible,
                child: const NotificationPage()),
            Visibility(
                visible: isWishlistPageVisible, child: const SavedPage()),
            Visibility(
                visible: isProfilePageVisible, child: const ProfilePage()),
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
                          isNotificationPageVisible = false;
                          isHomePageVisible = true;
                          isProfilePageVisible = false;
                          isWishlistPageVisible = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.list,
                      text: "WishList",
                      onPressed: () {
                        setState(() {
                          isNotificationPageVisible = false;
                          isHomePageVisible = false;
                          isProfilePageVisible = false;
                          isWishlistPageVisible = true;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.search,
                      text: "Search",
                      onPressed: () {
                        setState(() {
                          isNotificationPageVisible = true;
                          isHomePageVisible = false;
                          isProfilePageVisible = false;
                          isWishlistPageVisible = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.person,
                      text: "Profile",
                      onPressed: () {
                        setState(() {
                          isNotificationPageVisible = false;
                          isHomePageVisible = false;
                          isProfilePageVisible = true;
                          isWishlistPageVisible = false;
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
      // bottomNavigationBar: Container(
      //   height: MediaQuery.of(context).size.height * 0.09,
      //   color: const Color.fromARGB(255, 94, 60, 60),
      //   child: Padding(
      //     padding: const EdgeInsets.all(10),
      //     child: GNav(
      //       color: const Color.fromARGB(255, 255, 255, 255),
      //       activeColor: const Color.fromARGB(255, 255, 255, 255),
      //       // tabBackgroundColor: Colors.grey,
      //       tabActiveBorder: Border.all(
      //           color: const Color.fromARGB(255, 255, 255, 255), width: 1),
      //       gap: 8,
      //       padding: const EdgeInsets.all(10),
      //       tabs: [
      //         GButton(
      //           icon: Icons.home,
      //           text: "Home",
      //           onPressed: () {
      //             setState(() {
      //               isNotificationPageVisible = false;
      //               isHomePageVisible = true;
      //               isProfilePageVisible = false;
      //               isWishlistPageVisible = false;
      //             });
      //           },
      //         ),
      //         GButton(
      //           icon: Icons.list,
      //           text: "WishList",
      //           onPressed: () {
      //             setState(() {
      //               isNotificationPageVisible = false;
      //               isHomePageVisible = false;
      //               isProfilePageVisible = false;
      //               isWishlistPageVisible = true;
      //             });
      //           },
      //         ),
      //         GButton(
      //           icon: Icons.search,
      //           text: "Search",
      //           onPressed: () {
      //             setState(() {
      //               isNotificationPageVisible = true;
      //               isHomePageVisible = false;
      //               isProfilePageVisible = false;
      //               isWishlistPageVisible = false;
      //             });
      //           },
      //         ),
      //         GButton(
      //           icon: Icons.person,
      //           text: "Profile",
      //           onPressed: () {
      //             setState(() {
      //               isNotificationPageVisible = false;
      //               isHomePageVisible = false;
      //               isProfilePageVisible = true;
      //               isWishlistPageVisible = false;
      //             });
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
