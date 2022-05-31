import 'package:flutter/material.dart';
import 'package:qelem/common/app_palette.dart';
import 'package:qelem/common/constants.dart';
import 'package:qelem/presentation/pages/home_screen/home_screen.dart';
import 'package:qelem/presentation/pages/question/my_questions_page/my_questions_screen.dart';
import 'package:qelem/presentation/pages/my_profile/my_profile_overview/widgets/profile_app_bar.dart';
import 'package:qelem/presentation/pages/home_screen/widgets/home_app_bar.dart';
import 'package:qelem/presentation/pages/question/my_questions_page/widgets/common_app_bar.dart';
import 'package:go_router/go_router.dart';

import '../my_profile/my_profile_overview/my_profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String _title = Constants.home;
  AppBar _appBar = homeAppBar(Constants.home);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: IndexedStack(
        index: _selectedIndex,
        children: [homeScreen(), myQuestionsScreen(), const MyProfileScreen()],
      ),
      bottomNavigationBar: bottomNav(),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () => context.push('/post-question'),
        label: const Text("Ask"),
        backgroundColor: const Color(0xFF03DAC5),
        foregroundColor: Colors.black,
      ),
    );
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      backgroundColor: AppPalette.qelemPurple,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: Constants.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help),
          label: Constants.myQuestions,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: Constants.profile,
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onTap,
    );
  }

  void _onTap(int index) {
    _selectedIndex = index;
    switch (index) {
      case 0:
        {
          _title = Constants.home;
          _appBar = homeAppBar(_title);
        }
        break;
      case 1:
        {
          _title = Constants.myQuestions;
          _appBar = commonAppBar(_title);
        }
        break;
      case 2:
        {
          _title = Constants.profile;
          _appBar = profileAppBar(_title);
        }
        break;
    }
    setState(() {});
  }
}