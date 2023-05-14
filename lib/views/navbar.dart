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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Visibility(visible: isHomePageVisible, child: const HomePage()),
            Visibility(
                visible: isNotificationPageVisible,
                child: const NotificationPage()),
            Visibility(
                visible: isWishlistPageVisible, child: const WishListPage()),
            Visibility(
                visible: isProfilePageVisible, child: const ProfilePage()),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GNav(
            color: const Color.fromARGB(255, 255, 255, 255),
            activeColor: const Color.fromARGB(255, 255, 255, 255),
            // tabBackgroundColor: Colors.grey,
            tabActiveBorder: Border.all(
                color: const Color.fromARGB(255, 255, 255, 255), width: 1),
            gap: 8,
            padding: const EdgeInsets.all(8),
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
    );
  }
}
