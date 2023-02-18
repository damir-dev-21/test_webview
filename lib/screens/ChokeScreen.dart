// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_test/screens/DiaryScreen.dart';

import '../widgets/StopWatch.dart';
import '../widgets/Timer.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.idx}) : super(key: key);
  static const String routeName = '/home';

  static Route route({required int idx}) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => Home(
              idx: idx,
            ));
  }

  final int idx;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late String _timeString;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.idx);

    // _timeString = _formatDateTime(DateTime.now());

    // Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff1b2c57),
            leading: SizedBox(),
            toolbarHeight: 0,
            bottom: TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xff1b2c57),
                indicatorWeight: 4.0,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.hourglass_empty),
                    text: 'Stopwatch',
                  ),
                  Tab(
                    icon: Icon(Icons.timer),
                    text: 'Timer',
                  ),
                  Tab(
                    icon: Icon(Icons.sports_mma),
                    text: 'Diary',
                  ),
                ]),
          ),
          body: Container(
            color: const Color(0xff1b2c57),
            child: TabBarView(
                controller: _tabController,
                children: [timer(), StopWatch(), DiaryList()]),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}
