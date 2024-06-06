import 'package:flutter/material.dart';

import 'widgets/home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: AppBar(
            title: const Text('Home Page'),
          ),
        ),
      ),
      drawer: HomeDrawer(),
      body: Container(),
    );
  }
}