import 'package:flutter/material.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/screens/home/home_header.dart';
import 'package:museum_app/screens/home/tabbar_view.dart';

import 'tabbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    getMuseums();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  } // index of page

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HomeHeader(),
              TabBarSection(tabController: _tabController),
              TabBarViewSection(
                tabController: _tabController,
                popular: popular,
                recent: recent,
                rating: rating,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
