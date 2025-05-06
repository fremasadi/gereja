import 'package:flutter/material.dart';

class InputFormButton extends StatelessWidget {
  final Function() onClick;
  final String? titleText;
  final Icon? icon;
  final Color? color;
  final double? cornerRadius;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? borderWidth;

  const InputFormButton({
    super.key,
    required this.onClick,
    this.titleText,
    this.icon,
    this.color,
    this.cornerRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.textStyle,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(padding),
        maximumSize:
            WidgetStateProperty.all<Size>(const Size(double.maxFinite, 50)),
        minimumSize:
            WidgetStateProperty.all<Size>(const Size(double.maxFinite, 50)),
        backgroundColor: WidgetStateProperty.all<Color>(
            color ?? Theme.of(context).primaryColor),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius ?? 12.0),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 0,
            ),
          ),
        ),
      ),
      child: titleText != null
          ? Text(
              titleText!,
              style: textStyle ??
                  const TextStyle(color: Colors.white, fontFamily: 'SemiBold'),
            )
          : icon ?? const Icon(Icons.filter_list, color: Colors.white),
    );
  }
}
