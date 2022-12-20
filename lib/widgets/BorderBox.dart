import 'package:flutter/material.dart';
import 'package:metrics_app/utils/constants.dart';

class BorderBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double width, height;

  const BorderBox(
      {super.key,
      required this.padding,
      required this.width,
      required this.height,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: COLOR_WHITE,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              border: Border.all(color: COLOR_GREY.withAlpha(40), width: 2)),
          padding: padding ?? const EdgeInsets.all(8.0),
          child: Center(
            child: child,
          ),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: COLOR_WHITE,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              border: Border.all(color: COLOR_GREY.withAlpha(40), width: 2)),
          padding: padding ?? const EdgeInsets.all(8.0),
          child: Center(
            child: child,
          ),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: COLOR_WHITE,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              border: Border.all(color: COLOR_GREY.withAlpha(40), width: 2)),
          padding: padding ?? const EdgeInsets.all(8.0),
          child: Center(
            child: child,
          ),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: COLOR_WHITE,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              border: Border.all(color: COLOR_GREY.withAlpha(40), width: 2)),
          padding: padding ?? const EdgeInsets.all(8.0),
          child: Center(
            child: child,
          ),
        )
      ],
    );
  }
}
