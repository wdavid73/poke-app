import 'package:flutter/material.dart';
import 'package:poke_app/utils/styles_manager.dart';

class ButtonCustom extends StatelessWidget {
  final double? buttonWidth;
  final double? buttonHeight;
  final void Function() onPressed;
  final String? text;
  final Color fontColor;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? borderColor;
  final double elevation;
  final bool isDisable;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final double borderRadius;

  const ButtonCustom({
    super.key,
    this.buttonWidth,
    required this.onPressed,
    this.text,
    this.fontColor = Colors.white,
    this.buttonHeight,
    this.isLoading = false,
    this.backgroundColor,
    this.borderColor,
    this.elevation = 10,
    this.isDisable = false,
    this.child,
    this.padding,
    this.fontSize,
    this.borderRadius = 12,
  }) : assert(
            (text == null && child != null) || (child == null && text != null));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: !isLoading && !isDisable ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
            color: borderColor ?? backgroundColor ?? Colors.blueAccent,
            width: 1,
          ),
          elevation: elevation,
          shadowColor: Colors.black87,
          padding: padding,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.cyanAccent,
                  strokeWidth: 3,
                ),
              )
            : Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  child ??
                      Text(
                        "$text",
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: isLoading ? Colors.cyanAccent : fontColor,
                          fontSize: fontSize ?? 14,
                        ),
                      ),
                ],
              ),
      ),
    );
  }
}
