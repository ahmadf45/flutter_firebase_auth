import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'homePage.dart';
import 'transactionPage.dart';
import 'basketPage.dart';
import 'enterPage.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _page = 0;
  GlobalKey _bottomNavKey = GlobalKey();

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    TransactionPage(),
    BasketPage(),
    Text("Chat"),
    EnterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: _widgetOptions.elementAt(_page),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavKey,
        index: 0,
        height: 50,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.shopping_basket, size: 30),
          Icon(Icons.chat, size: 30),
          Icon(Icons.transit_enterexit, size: 30),
        ],
        color: Colors.amber,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.amberAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
