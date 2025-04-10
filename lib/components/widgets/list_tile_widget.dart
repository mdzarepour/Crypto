import 'package:flutter/material.dart';

import '../constants/solid_colors.dart';

class ListTileWidget extends StatelessWidget {
  final int index;
  final String rank;
  final String symbol;
  final String name;
  final String priceUsd;
  final String changePercent24Hr;
  final Icon icon;

  const ListTileWidget({
    super.key,
    required this.index,
    required this.changePercent24Hr,
    required this.icon,
    required this.name,
    required this.priceUsd,
    required this.rank,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return ListTile(
      leadingAndTrailingTextStyle: textTheme.bodySmall,
      leading: Text(
        rank,
        style: textTheme.bodyMedium,
      ),
      subtitle: Text(symbol),
      title: Text(
        name,
        style: textTheme.bodyMedium,
      ),
      trailing: SizedBox(
        width: 150,
        height: double.infinity,
        child: Row(
          spacing: 15,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  priceUsd,
                ),
                Text(
                    style: TextStyle(
                      color: _getChangePercent24HrColor(
                          double.parse(changePercent24Hr), index),
                    ),
                    changePercent24Hr)
              ],
            ),
            icon
          ],
        ),
      ),
    );
  }

  Color? _getChangePercent24HrColor(double changes, int index) {
    if (changes < 0) {
      return SolidColors.redColor;
    } else {
      return SolidColors.greenColor;
    }
  }
}
