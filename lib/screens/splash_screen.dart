import 'package:crypto_pricing/components/constants/strings.dart';
import 'package:crypto_pricing/components/models/crypto_model.dart';
import 'package:crypto_pricing/screens/home_screen.dart';
import 'package:crypto_pricing/services/dio_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: SpinKitThreeBounce(color: Colors.grey, size: 20),
      );
    } else if (snapshot.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error),
            const SizedBox(height: 40),
            const Text(Strings.connectionError),
            const SizedBox(height: 20),
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
    } else if (snapshot.hasData) {
      List<CryptoModel> correntCryptoList = snapshot.data!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => MainScreen(cryptoList: correntCryptoList),
          ),
        );
      });
      return const SizedBox.shrink();
    } else {
      return const SizedBox.shrink();
    }
  }
}
