import 'package:flutter/material.dart';
import 'package:snap_share_application/src/core/utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final bool transparent;
  final bool isTextBlackColor;
  final bool isLoading;
  final EdgeInsets margin;
  final double height;
  final double width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  final Color? backgroundColor;
  const CustomButton(
      {super.key,
      this.onPressed,
      required this.buttonText,
      this.transparent = false,
      required this.margin,
      required this.width,
      required this.height,
      this.fontSize,
      this.radius = 4,
      this.icon,
      this.isTextBlackColor = true,
      this.backgroundColor,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : backgroundColor ?? Theme.of(context).primaryColor,
      minimumSize: Size(width, height),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Center(
        child: SizedBox(
            width: width,
            child: Padding(
              padding: margin,
              child: TextButton(
                onPressed: onPressed,
                style: flatButtonStyle,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  icon != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(icon,
                              color: transparent
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).cardColor),
                        )
                      : const SizedBox(),
                  isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Text(buttonText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: transparent
                                ? Theme.of(context).primaryColor
                                : isTextBlackColor
                                    ? Colors.white
                                    : Theme.of(context).cardColor,
                            fontSize: fontSize ??
                                Dimensions.subheadingfontSizeDefault,
                          )),
                ]),
              ),
            )));
  }
}
