import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget{
  Color bgColor;
  Widget mChild;
  Color? borderColor;
  double? bRadius;
  double mWidth;
  double mHeight;


  CustomContainer({this.bgColor = Colors.white, required this.mChild, this.borderColor,
      this.bRadius, this.mWidth=100, this.mHeight=100});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mWidth,
      height: mHeight,
      child: Center(child: mChild),
      decoration: BoxDecoration(
        color: bgColor,
        border: borderColor != null ? Border.all(
          color: borderColor!,
          width: 1
        ) : null,
        borderRadius: BorderRadius.circular(bRadius ?? 0.0)
      ),
    );
  }
}