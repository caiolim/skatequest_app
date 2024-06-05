// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = HomeController();
  var currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/sls-logo_thumb-detail.png',
                  width: 32.0,
                  height: 32.0,
                ),
              ),
            ],
          ),
          Image.asset('assets/images/skate-wallpaper.jpg'),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleSession('Rolês na semana'),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _sessionsOnWeek(),
                    _allDaysSkating(),
                    _buttonAddDaySkate(),
                  ],
                ),
                SizedBox(height: 24.0),
                _titleSession('Tricks favoritas'),
                SizedBox(height: 16.0),
                _favoriteTricks(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleSession(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
      ),
    );
  }

  Widget _buttonAddDaySkate() {
    return Column(
      children: [
        RawMaterialButton(
          onPressed: _controller.skateToday
              ? null
              : () => setState(
                    () => _controller.confirmSkateToday(),
                  ),
          elevation: 2.0,
          fillColor: _controller.skateToday
              ? Colors.transparent
              : Color.fromARGB(16, 0, 0, 0),
          child: Column(
            children: [
              Icon(
                Icons.skateboarding,
                size: 24.0,
              ),
              SizedBox(height: 8.0),
              Text(
                '+ um dia \nno rolê',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.0,
                ),
              )
            ],
          ),
          padding: EdgeInsets.all(24.0),
          shape: CircleBorder(),
        ),
      ],
    );
  }

  Widget _sessionsOnWeek() {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          Text(
            '${_controller.skateDaysOnWeek}/7',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'rolês essa \nsemana',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }

  Widget _allDaysSkating() {
    return Column(
      children: [
        Text(
          '${_controller.daysSkate}',
          style: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'dias no \nrolê',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
          ),
        ),
      ],
    );
  }

  Widget _favoriteTricks() {
    return Container(
      height: 240.0,
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            minLeadingWidth: 60.0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.auto_graph),
            ),
            title: Text('Nollie'),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text('80%'),
            ),
          ),
        ),
      ),
    );
  }
}
