import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  static const String routeName = '/root';

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;

  List<Widget> screens() {
    return [
      const Center(
        child: Text(
          'Screen01',
          style: TextStyle(color: Colors.white),
        ),
      ),
      const Center(
        child: Text(
          'Screen02',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ];
  }

  void _tabListener() {
    setState(() {});
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
  }

  @override
  void dispose() {
    controller!.removeListener(_tabListener);

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
