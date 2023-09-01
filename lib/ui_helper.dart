import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors{

  static final Color whiteColor = Color(0xffffffff);
  static final Color greyColor = Color(0xffF6F6F6);
  static final Color blackColor = Color(0xff1A1B32);
  static final Color greenColor = Color(0xff2BA943);



}

Widget hSpacer({mHeight = 11.0}){
  return SizedBox(
    height: mHeight,
  );
}

Widget wSpacer({mWidth = 11.0}){
  return SizedBox(
    width: mWidth,
  );
}

// textStyles

TextStyle mTextStyle43({
  Color mColor= Colors.black,
  FontWeight mWeight = FontWeight.normal,
}){
  return TextStyle(
    fontSize: 43,
    color: mColor,
    fontWeight: mWeight,
    fontFamily: 'Montserrat'
  );
}

TextStyle mTextStyle34({
  Color mColor= Colors.black,
  FontWeight mWeight = FontWeight.normal,
}){
  return TextStyle(
      fontSize: 34,
      color: mColor,
      fontWeight: mWeight,
      fontFamily: 'Montserrat'
  );
}

TextStyle mTextStyle25({
  Color mColor= Colors.black,
  FontWeight mWeight = FontWeight.normal,
}){
  return TextStyle(
      fontSize: 25,
      color: mColor,
      fontWeight: mWeight,
      fontFamily: 'Montserrat'
  );
}


TextStyle mTextStyle12({
  Color mColor= Colors.black,
  FontWeight mWeight = FontWeight.normal,
}){
  return TextStyle(
      fontSize: 12,
      color: mColor,
      fontWeight: mWeight,
      fontFamily: 'Montserrat'
  );
}


TextStyle mTextStyle16({
  Color mColor= Colors.black,
  FontWeight mWeight = FontWeight.normal,
}){
  return TextStyle(
      fontSize: 16,
      color: mColor,
      fontWeight: mWeight,
      fontFamily: 'Montserrat'
  );
}


