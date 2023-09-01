import 'package:expenser_46/app_widgets/custom_container.dart';
import 'package:flutter/material.dart';

class CardItemWidget extends StatelessWidget {
  String? title;
  List<Widget>? arrWidgets;

  CardItemWidget({this.title, this.arrWidgets});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      mWidth: double.infinity,
        bgColor: Colors.grey,
        bRadius: 16,
        mChild: arrWidgets!=null ? Row(
      children: arrWidgets!
    ) : Text(title!)
    );
  }
}
