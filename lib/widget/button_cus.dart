import 'package:flutter/material.dart';
import '../theme.dart';
import '../util/dimensions.dart';

class ButtonCus extends StatelessWidget {
  final Function onPressed;
  final String textButton;
  final Color buttomcolor;

  const ButtonCus(
      {super.key,
      required this.textButton,
      required this.onPressed,
      required this.buttomcolor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          backgroundColor: buttomcolor == 'bg1Color' ? bg1Color : null,
        ),
        onPressed: onPressed as void Function(),
        child: Text(
          textButton,
          style: primaryTextStyle.copyWith(
              fontSize: Dimensions.FONT_SIZE_NORMAL,
              color: bg6color,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
