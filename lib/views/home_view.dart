// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
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
                StreamBuilder<QuerySnapshot>(
                  stream: _controller.listSkateDays().snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: Text('Falha na conexão.'),
                        );
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        final dados = snapshot.requireData;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buttonAddDaySkate(),
                            _allDaysSkating(daysSkate: dados.docs.length),
                            _sessionsOnWeek(),
                          ],
                        );
                    }
                  },
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
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.hasSkateToday(context).snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text('Falha na conexão.'),
            );
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            final data = snapshot.requireData;
            return Column(
              children: [
                RawMaterialButton(
                  onPressed: data.docs.isNotEmpty
                      ? null
                      : () => _controller.addDaySkate(context: context),
                  elevation: 2.0,
                  fillColor: data.docs.isNotEmpty
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
      },
    );
  }

  Widget _sessionsOnWeek() {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.listSkateDaysOnWeek().snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text('Falha na conexão.'),
            );
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            final data = snapshot.requireData;

            return Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: [
                  Text(
                    '${data.docs.length}/7',
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
      },
    );
  }

  Widget _allDaysSkating({int daysSkate = 0}) {
    return Column(
      children: [
        Text(
          '$daysSkate',
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
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.favoriteTricks().snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text('Falha na conexão.'),
            );
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            final data = snapshot.requireData;

            return data.docs.isNotEmpty
                ? Container(
                    height: 240.0,
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        dynamic item = data.docs[index].data();

                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            minLeadingWidth: 60.0,
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.auto_graph),
                            ),
                            title: Text(
                              item['name'],
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.keyboard_arrow_right_rounded,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox();
        }
      },
    );
  }
}
