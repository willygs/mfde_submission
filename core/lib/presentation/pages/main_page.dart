import 'package:core/styles/colors.dart';
import 'package:core/utils/routes.dart';

import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavIndex = 0;

  final List<Widget> _listWidget = const [HomeMoviePage(), HomeTvPage()];

  final List<BottomNavigationBarItem> _bottomNavBarItems =  const   [
     BottomNavigationBarItem(
      icon:   Icon(Icons.movie_outlined),
      label: 'Movie',
    ),
    BottomNavigationBarItem(
      icon:  Icon(Icons.tv_rounded),
      label: 'TV',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children:  [
           const UserAccountsDrawerHeader(
              currentAccountPicture:  CircleAvatar(
                backgroundImage:  AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist Movies'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_MOVIE_ROUTE);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist TV'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_TV_ROUTE);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              if (bottomNavIndex == 0) {
                Navigator.pushNamed(context, SEARCH_ROUTE);
              } else {
                Navigator.pushNamed(context, SEARCH_TV_ROUTE);
              }
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: _listWidget[bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kBottomNav,
        currentIndex: bottomNavIndex,
        selectedItemColor: kMikadoYellow,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            bottomNavIndex = selected;
          });
        },
      ),
    );
  }
}
