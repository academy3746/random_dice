// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:random_dice/common/widgets/back_handler_button.dart';
import 'package:random_dice/screens/home_screen.dart';
import 'package:random_dice/screens/settings_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  static const String routeName = '/root';

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;

  double threshold = 2.7;

  BackHandlerButton? backHandlerButton;

  List<Widget> screens() {
    return [
      const HomeScreen(number: 1),
      SettingsScreen(
        threshold: threshold,
        onThresholdChange: _onThresholdChange,
      ),
    ];
  }

  void _tabListener() {
    setState(() {});
  }

  void _onThresholdChange(double value) {
    setState(() {
      threshold = value;
    });
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: controller!.index,
      onTap: (index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.edgesensor_high_outlined),
          label: '흔들어요!',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '설정',
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: 2,
      vsync: this,
    );

    controller!.addListener(_tabListener);

    backHandlerButton = BackHandlerButton(context: context);
  }

  @override
  void dispose() {
    controller!.removeListener(_tabListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (backHandlerButton != null) {
          return backHandlerButton!.onWillPop();
        }

        return Future.value(false);
      },
      child: Scaffold(
        body: TabBarView(
          controller: controller,
          children: screens(),
        ),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }
}
