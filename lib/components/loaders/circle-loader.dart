import 'package:flutter/material.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class CircleLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var block = SizeConfig.block;
    return Container(
      height: block * 8.5,
      width: block * 8.5,
      decoration: BoxDecoration(color: transparent, shape: BoxShape.circle),
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: black),
          child: CircularProgressIndicator(strokeWidth: block),
        ),
      ),
    );
  }
}
