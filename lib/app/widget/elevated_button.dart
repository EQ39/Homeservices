
import 'package:flutter/material.dart';
import 'package:homeservice/app/util/theme.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color color;
  final double height;
  final double width;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.color,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shadowColor: ThemeProvider.blackColor,
              foregroundColor: ThemeProvider.whiteColor,
              elevation: 3,
              shape: (RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              )),
              padding: const EdgeInsets.all(0)),
          child: child),
    );
  }
}
