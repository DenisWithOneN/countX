import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test_navbar/pages/home_page.dart';
import 'package:test_navbar/pages/timer_page.dart';
import 'package:test_navbar/pages/favourites_page.dart';
import 'package:test_navbar/common/colors.dart' as colors;

void main() {
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const TimerPage(),
    const FavouritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    
        routes: {
          '/home': (context) =>  const HomePage(),
          '/timer': (context) =>  const TimerPage(),
          '/favourites': (context) =>  const FavouritesPage(),
        },
        home: Scaffold(
      appBar: appBar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: colors.primaryColor,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GNav(
                gap: 8,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                tabBackgroundColor: colors.secondaryColor,
                backgroundColor: colors.primaryColor,
                color: colors.tertiaryColor,
                activeColor: colors.contrastColor,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.timer,
                    text: 'Timer',
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Favourites',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          )),
    ));
  }
 AppBar appBar() {
    return AppBar(
      title: const Text('CountX',
          style: TextStyle(
              color: colors.contrastColor,
              fontSize: 24,
              fontWeight: FontWeight.bold)),
      backgroundColor: colors.primaryColor,
      centerTitle: true,

      //actions used to mark the end of the app bar
      actions: [
        GestureDetector(
          //onTap function
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
                // ignore: use_full_hex_values_for_flutter_colors
                color: colors.tertiaryColor,
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.settings, color: Colors.white),
          ),
        )
      ],
    );
  }
}
