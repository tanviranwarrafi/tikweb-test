import 'package:flutter/material.dart';
import 'package:tikweb_test_app/utils/constraints.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget textField;
  final double radius;

  TextFieldContainer({this.textField, this.radius});

  @override
  Widget build(BuildContext context) {
    var block = SizeConfig.block;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius == null ? block * 2.5 : radius),
        color: Theme.of(context).accentColor,
        boxShadow: [
          BoxShadow(color: Theme.of(context).canvasColor, offset: Offset(2, 1), blurRadius: 8),
        ],
      ),
      child: textField,
    );
  }
}

outlineBorder({double radius, Color color, double width}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius == null ? 0 : radius),
    borderSide: BorderSide(color: color == null ? black54 : color, width: width == null ? 0 : width),
  );
}

hintStyle({Color color}) {
  var block = SizeConfig.block;
  return TextStyle(color: color == null ? grey : color, fontSize: block * 3.8);
}

labelStyle({Color color}) {
  var block = SizeConfig.block;
  return TextStyle(color: color == null ? black : color, fontSize: block * 3.8);
}

errorStyle({Color color}) {
  var block = SizeConfig.block;
  return TextStyle(color: color == null ? red : color, fontSize: block * 3.5);
}
