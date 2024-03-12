import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_dice/screens/home_screen.dart';
import 'package:random_dice/screens/settings_screen.dart';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  static const String routeName = '/root';

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;

  double threshold = 2.7;

  int number = 1;

  ShakeDetector? shakeDetector;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: screens().length,
      vsync: this,
    );

    controller!.addListener(_tabListener);

    shakeDetector = ShakeDetector.autoStart(
        onPhoneShake: _onPhoneShake,
        shakeSlopTimeMS: 100,
        shakeThresholdGravity: threshold
    );
  }

  List<Widget> screens() {
    return [
      HomeScreen(number: number),
      SettingsScreen(
        threshold: threshold,
        onThresholdChange: _onThresholdChange,
      ),
    ];
  }

  _tabListener() {
    setState(() {});
  }

  _onThresholdChange(double value) {
    setState(() {
      threshold = value;
    });
  }

  void _onPhoneShake() {
    final rand = Random();

    setState(() {
      number = rand.nextInt(5) + 1;
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
  void dispose() {
    controller!.removeListener(_tabListener);

    shakeDetector!.stopListening();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: screens(),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
