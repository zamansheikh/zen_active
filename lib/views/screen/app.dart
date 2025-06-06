import 'package:flutter/material.dart';
import 'package:zenactive/views/components/custom_nav_bar.dart';
import 'package:zenactive/views/screen/challenges/challenges_page.dart';
import 'package:zenactive/views/screen/community/community_app.dart';
import 'package:zenactive/views/screen/home/home_screen.dart';
import 'package:zenactive/views/screen/profile/profile_page.dart';
import 'package:zenactive/views/screen/workout/workout_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _index = 0;
  final int _defaultAnimationDuration = 200;
  PageController controller = PageController(initialPage: 0);

  void changePage(int index) {
    setState(() {
      controller.animateToPage(index,
          duration: Duration(milliseconds: _defaultAnimationDuration),
          curve: Curves.decelerate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (value) {
          setState(() {
            _index = value;
          });
        },
        children: [
          HomeScreen(
            key: PageStorageKey('a'),
            changePage: changePage,
          ),
          ChallengesPage(
            key: PageStorageKey('b'),
          ),
          CommunityApp(
            key: PageStorageKey('c'),
          ),
          WorkoutPage(
            key: PageStorageKey('d'),
          ),
          ProfilePage(
            key: PageStorageKey('e'),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        index: _index,
        onItemTap: (index) {
          controller.animateToPage(
            index,
            duration: Duration(
              milliseconds: _defaultAnimationDuration * (index - _index).abs(),
            ),
            curve: Curves.linear,
          );
        },
      ),
    );
  }
}
