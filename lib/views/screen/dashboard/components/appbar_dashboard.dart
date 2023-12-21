import 'package:flutter/material.dart';

import '../../../../theme.dart';

class AppbarDash extends StatelessWidget {
  const AppbarDash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(
              Icons.menu,
              size: 24.0,
              color: Colors.black87,
            ),
          ),
        ),
        Text(
          " Berskain Shop ",
          style: primaryTextStyle.copyWith(color: Colors.black87),
        ),
      ],
    );
  }
}
