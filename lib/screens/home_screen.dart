import 'package:flutter/material.dart';
import 'package:random_dice/common/constants/colors.dart';
import 'package:random_dice/common/constants/gaps.dart';
import 'package:random_dice/common/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.number,
  });

  final int number;

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('assets/images/dice$number.png'),
        ),
        Gaps.v32,
        Text(
          '행운의 숫자',
          style: TextStyle(
            color: secondaryColor,
            fontSize: Sizes.size20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Gaps.v12,
        Text(
          number.toString(),
          style: const TextStyle(
            color: primaryColor,
            fontSize: Sizes.size60,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}
