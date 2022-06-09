import 'package:flutter/material.dart';
import 'package:flutter_group_on/core/constants/screens/screen_constants.dart';
import 'package:flutter_group_on/screens/home_screen/view/home_screen.dart';
import 'package:flutter_group_on/screens/login_screen/view/login_screen.dart';

import '../../core/constants/colors/color_constants.dart';
import '../account_screen/view/account_screen.dart';

class tabViewClass extends StatefulWidget {
  tabViewClass({Key? key}) : super(key: key);

  @override
  State<tabViewClass> createState() => tabViewClassState();
}

class tabViewClassState extends State<tabViewClass> {
  int _selectedTabIndex = 0;

  List _pages = [HomeScreen(), AccountScreen()];

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
      print("index..." + index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedTabIndex],
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //print("wqwas");
          //_openCamera(context);
          Navigator.pushNamed(context, addActivityScreen)
              .then((_) => setState(() {}));
          //addProduct();
        },
        tooltip: 'Add Transaction',
        backgroundColor: backgroundTopColor,
        foregroundColor: Colors.black87,
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }

  Widget get bottomNavigationBar {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomAppBar(
            clipBehavior: Clip.antiAlias,
            notchMargin: 5,
            shape: CircularNotchedRectangle(),
            child: BottomNavigationBar(
              currentIndex: _selectedTabIndex,
              onTap: _changeIndex,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey[500],
              showUnselectedLabels: true,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.person),
                  label: "My Account",
                ),
              ],
            ),
          ),
        ));
  }
}
