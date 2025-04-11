import 'package:crypto_pricing/components/constants/solid_colors.dart';
import 'package:crypto_pricing/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto',
      theme: ThemeData(
        scaffoldBackgroundColor: SolidColors.backgroundColor,
        inputDecorationTheme: _getInputTheme(),
        appBarTheme: _getAppBarTheme(),
        outlinedButtonTheme: _getButtonTheme(),
        iconTheme: _getIconTheme(),
        textTheme: _getTextTheme(),
        snackBarTheme: _getSnackBarTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }

  // SnackBarThem --------->
  SnackBarThemeData _getSnackBarTheme() {
    return SnackBarThemeData(
      backgroundColor: SolidColors.greenColor,
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    );
  }

  // TextFieldThme --------->
  InputDecorationTheme _getInputTheme() {
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

  // TextTheme --------->
  TextTheme _getTextTheme() {
    return TextTheme(
      bodyMedium: const TextStyle(color: SolidColors.white, fontSize: 20),
      bodyLarge: const TextStyle(color: SolidColors.white, fontSize: 20),
      bodySmall: const TextStyle(color: SolidColors.white, fontSize: 15),
      labelMedium: TextStyle(color: SolidColors.greenColor, fontSize: 20),
    );
  }

  // IconTheme --------->
  IconThemeData _getIconTheme() {
    return const IconThemeData(size: 25, color: SolidColors.greyColor);
  }

  // ButtonTheme --------->
  OutlinedButtonThemeData _getButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(150, 30),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  // AppBar theme --------->
  AppBarTheme _getAppBarTheme() {
    return AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: SolidColors.backgroundColor,
      centerTitle: true,
      titleTextStyle: const TextStyle(color: SolidColors.white, fontSize: 20),
    );
  }
}
