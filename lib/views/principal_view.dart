// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import './home_view.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  var currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigatorBar(),
      body: <Widget>[
        HomeView(),
        Center(
          child: Text('minhas tricks'),
        ),
        Center(
          child: Text('conquistas'),
        ),
        Center(
          child: Text('perfil'),
        ),
      ][currentPageIndex],
    );
  }

  Widget _bottomNavigatorBar() {
    return NavigationBar(
      selectedIndex: currentPageIndex,
      onDestinationSelected: (index) =>
          setState(() => currentPageIndex = index),
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.skateboarding),
          label: 'Minhas tricks',
        ),
        NavigationDestination(
          icon: Badge(child: Icon(Icons.star)),
          label: 'Conquistas',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}
