import 'package:crypto_pricing/components/constants/strings.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Strings.appbarImage, height: 50),
          const SizedBox(width: 10),
          const Text(Strings.appBarTitle),
        ],
      ),
    );
  }
}
