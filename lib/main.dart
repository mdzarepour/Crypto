import 'package:crypto/components/constants/solid_colors.dart';
import 'package:crypto/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: inputTheme(),
        appBarTheme: appBarTheme(),
        scaffoldBackgroundColor: SolidColors.backgroundColor,
        outlinedButtonTheme: borderTheme(),
        iconTheme: iconTheme(),
        textTheme: textTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }

  InputDecorationTheme inputTheme() {
    return InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        borderSide: BorderSide(color: SolidColors.greenColor!),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
    );
  }

  TextTheme textTheme() {
    return TextTheme(
      bodyMedium: const TextStyle(color: SolidColors.white, fontSize: 20),
      bodyLarge: const TextStyle(color: SolidColors.white, fontSize: 20),
      bodySmall: const TextStyle(color: SolidColors.white, fontSize: 15),
      labelMedium: TextStyle(color: SolidColors.greenColor, fontSize: 20),
    );
  }

  IconThemeData iconTheme() {
    return const IconThemeData(size: 25, color: SolidColors.greyColor);
  }

  OutlinedButtonThemeData borderTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(150, 30),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  AppBarTheme appBarTheme() {
    return AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: SolidColors.backgroundColor,
      centerTitle: true,
      titleTextStyle: const TextStyle(color: SolidColors.white, fontSize: 20),
    );
  }
}
