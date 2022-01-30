import 'package:ecommerce/constants.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/tabs/hometab.dart';
import 'package:ecommerce/tabs/savetab.dart';
import 'package:ecommerce/tabs/searchtab.dart';
import 'package:ecommerce/widgets.dart/bottomtabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseServices _firebaseServices = FirebaseServices();

  PageController _tabsPageController;
  int _selectedTab = 0;

  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: PageView(
            controller: _tabsPageController,
            onPageChanged: (num) {
              setState(() {
                _selectedTab = num;
              });
            },
            children: [
              HomeTab(),
              SearchTab(),
              SaveTab(),
            ],
          )),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              setState(() {
                _tabsPageController.animateToPage(num,
                    duration: Duration(microseconds: 300),
                    curve: Curves.easeOutCubic);
              });
            },
          ),
        ],
      ),
    );
  }
}
