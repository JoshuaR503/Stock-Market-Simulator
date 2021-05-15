import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:simulador/screens/holdings/holdings.dart';
import 'package:simulador/screens/portfolio/portfolio.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> tabs = [
    FadeIn(duration: Duration(milliseconds: 700), child: PortfolioScreen()),
    FadeIn(duration: Duration(milliseconds: 700), child: HoldingsScreen()),
    FadeIn(duration: Duration(milliseconds: 700), child: PortfolioScreen()),
    FadeIn(duration: Duration(milliseconds: 700), child: PortfolioScreen()),

    // HoldingsScreen(),
    // PortfolioScreen(),
    // PortfolioScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: tabs.elementAt(_selectedIndex),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SalomonBottomBar(
            currentIndex: _selectedIndex,
            onTap: (i) => setState(() => _selectedIndex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.globeAmericas),
                title: Text("Portafolio"),
                selectedColor: Colors.black87
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.chartBar),
                title: Text("Posiciones"),
                selectedColor: Colors.black87
              ),

              /// Search
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.newspaper),
                title: Text("Search"),
                selectedColor: Colors.black87
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                selectedColor: Colors.black87
              ),
            ],
          )
        )
      ),
    );
  }
}
