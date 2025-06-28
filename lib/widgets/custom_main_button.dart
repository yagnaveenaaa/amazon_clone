import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  final double buttonWidth;
  const CustomMainButton(
      {Key? key,
      required this.child,
      required this.color,
      required this.isLoading,
      required this.onPressed,
      required this.buttonWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils().getScreenSize();
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : child,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(size.width * buttonWidth, 40),
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
