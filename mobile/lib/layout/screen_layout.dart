import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alexatek/utils/global_variables.dart';

import '../utils/colors.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  int _currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentPage,
        backgroundColor: Theme.of(context).colorScheme.background,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Icon(
                (_currentPage == 0) ? Icons.home : Icons.home_outlined,
                color: primaryColor,
              ),
            ),
            label: '',
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Icon(
                Icons.square,
                color: primaryColor,
                size: 26,
              ),
            ),
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Icon(
                Icons.square_outlined,
                color: primaryColor,
                size: 26,
              ),
            ),
            label: '',
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Icon(
                Icons.collections,
                color: primaryColor,
                size: 26,
              ),
            ),
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Icon(
                Icons.collections_outlined,
                color: primaryColor,
                size: 26,
              ),
            ),
            label: '',
            backgroundColor: secondaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
