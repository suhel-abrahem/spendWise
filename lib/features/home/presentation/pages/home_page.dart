import 'package:flutter/material.dart';
import 'package:spend_wise/config/route/routes_manager.dart';
import 'package:spend_wise/core/resource/main_page/main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MainPage(
      body: ListView(children: [Text("ez")]),
      title: "Home Page",
      pagePath: RoutesPath.homePage,
    );
  }
}
