import 'package:crypto_pricing/components/constants/solid_colors.dart';
import 'package:crypto_pricing/components/constants/strings.dart';
import 'package:crypto_pricing/models/crypto_model.dart';
import 'package:crypto_pricing/screens/home_screen.dart';
import 'package:crypto_pricing/services/dio_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<List<CryptoModel>> futureCryptoList;
  @override
  void initState() {
    super.initState();
    futureCryptoList = DioServices().fetchCryptoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<CryptoModel>>(
            future: futureCryptoList,
            builder: _buildFutureBody,
          ),
        ),
      ),
    );
  }

  Widget _buildFutureBody(context, snapshot) {
    var textTheme = Theme.of(context).textTheme;
    // error condition ---------------->
    if (snapshot.hasError) {
      return Center(
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error),
            const Text(Strings.connectionError),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  futureCryptoList = DioServices().fetchCryptoList();
                });
              },
              child: Text(Strings.retry, style: textTheme.bodyMedium),
            ),
          ],
        ),
      );
      // accurate condition ---------------->
    } else if (snapshot.hasData) {
      List<CryptoModel> correntCryptoList = snapshot.data!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => HomeScreen(cryptoList: correntCryptoList),
          ),
        );
      });
      return SizedBox.shrink();
      // waiting condition ---------------->
    } else {
      return SpinKitThreeBounce(color: SolidColors.greyColor, size: 15);
    }
  }
}
