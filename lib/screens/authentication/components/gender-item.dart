import 'package:flutter/material.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class GenderItem extends StatelessWidget {
  final String title;
  final String selectedItem;
  final Function onTap;

  GenderItem({this.title, this.selectedItem, this.onTap});

  @override
  Widget build(BuildContext context) {
    var block = SizeConfig.block;
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: block * 4, fontWeight: FontWeight.w500)),
          SizedBox(width: block * 2.5),
          Icon(selectedItem == title ? Icons.radio_button_checked : Icons.radio_button_off, color: black),
        ],
      ),
    );
  }
}
