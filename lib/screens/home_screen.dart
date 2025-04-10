import 'package:crypto_pricing/components/constants/solid_colors.dart';
import 'package:crypto_pricing/components/constants/strings.dart';
import 'package:crypto_pricing/components/widgets/app_bar.dart';
import 'package:crypto_pricing/components/widgets/list_tile_widget.dart';
import 'package:crypto_pricing/models/crypto_model.dart';
import 'package:crypto_pricing/services/dio_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<CryptoModel> cryptoList;
  const HomeScreen({super.key, required this.cryptoList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late List<CryptoModel> cryptoList;
  bool listStatus = false;

  @override
  void initState() {
    cryptoList = widget.cryptoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarWidget()),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: TextField(
                onChanged: (value) {
                  String input = searchController.text;

                  _searchInCyptoList(input);
                },
                focusNode: focusNode,
                maxLength: 20,
                cursorColor: SolidColors.greenColor,
                controller: searchController,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await _refreshCryptoList(cryptoList);
                  _showSnackBar(
                    listStatus == false ? Strings.refreshed : Strings.tryAgain,
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    focusNode.unfocus();
                  },
                  child: ListView.builder(
                    itemCount: cryptoList.length,
                    itemBuilder: (context, index) {
                      return ListTileWidget(
                        index: index,
                        changePercent24Hr: cryptoList[index].changePercent24Hr
                            .toString()
                            .substring(0, 10),
                        icon: _getListTileIcon(
                          cryptoList[index].changePercent24Hr,
                          index,
                        ),
                        name: cryptoList[index].name,
                        priceUsd: cryptoList[index].priceUsd
                            .toString()
                            .substring(0, 12),
                        rank: cryptoList[index].rank.toString(),
                        symbol: cryptoList[index].symbol,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon _getListTileIcon(double changes, int index) {
    if (changes < 0) {
      return const Icon(Icons.arrow_downward, color: SolidColors.redColor);
    } else {
      return Icon(Icons.arrow_upward, color: SolidColors.greenColor);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: SolidColors.greenColor,
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 10, right: 8, left: 8),
        duration: const Duration(seconds: 1),
        content: Center(child: Text(message)),
      ),
    );
  }
  //TODO change this logic for detect if the list is changed or not

  _refreshCryptoList(List<CryptoModel> oldList) async {
    int counter = 0;
    List<CryptoModel> newList = await DioServices().fetchCryptoList();
    for (int i = 0; i < oldList.length; i++) {
      if (oldList[i].priceUsd.toString() != (newList[i].priceUsd.toString())) {
        counter++;
      }
    }
    if (counter == 0) {
      listStatus = true;
    } else if (counter > 0) {
      listStatus = false;
    }
    setState(() {
      cryptoList = newList;
    });
  }

  _searchInCyptoList(String input) {
    List<CryptoModel> searchList = [];
    searchList =
        widget.cryptoList.where((element) {
          if (element.name.toLowerCase().contains(input.toLowerCase())) {
            return true;
          } else {
            return false;
          }
        }).toList();

    setState(() {
      cryptoList = searchList;
    });
  }
}
