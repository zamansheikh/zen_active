import 'package:flutter/material.dart';
import 'package:zen_active/views/components/custom_nav_bar.dart';
import 'package:zen_active/views/screen/Profile/profile_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: CustomAppBar(),
      // ),
      body: ProfilePage(),
      bottomNavigationBar: CustomNavBar(
        index: _index,
        onItemTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
