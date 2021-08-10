import 'package:flutter/material.dart';
import 'package:tikweb_test_app/utils/size-config.dart';

class DropDownContainer extends StatelessWidget {
  final double containerWidth;
  final double containerHeight;
  final Color background;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final Widget dropDown;

  DropDownContainer({
    this.containerWidth,
    this.containerHeight,
    this.background,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.dropDown,
  });

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth;
    var block = SizeConfig.block;
    return Container(
      height: containerHeight == null ? block * 8 : containerHeight,
      width: containerWidth == null ? width : containerWidth,
      decoration: BoxDecoration(
        color: background == null ? Colors.grey[50] : background,
        border: Border.all(color: borderColor == null ? Colors.grey[300] : borderColor, width: borderWidth == null ? 0 : borderWidth),
        borderRadius: BorderRadius.circular(borderRadius == null ? 0 : borderRadius),
      ),
      child: dropDown,
    );
  }
}

class DropDownLabel extends StatelessWidget {
  final IconData icon;
  final Color labelColor;
  final double iconSize;
  final String label;
  final FontWeight fontWeight;
  final double iconPadding;
  final Color iconColor;

  DropDownLabel({this.icon, this.iconSize, this.labelColor, this.fontWeight, this.label, this.iconPadding, this.iconColor});

  @override
  Widget build(BuildContext context) {
    var block = SizeConfig.block;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon == null ? SizedBox.shrink() : SizedBox(width: iconPadding == null ? block * 2 : iconPadding),
        icon == null
            ? SizedBox.shrink()
            : Icon(icon, color: iconColor == null ? Colors.grey : iconColor, size: iconSize == null ? block * 4 : iconSize),
        icon == null ? SizedBox.shrink() : SizedBox(width: iconPadding == null ? block * 2 : iconPadding),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: block * 3.5,
            color: labelColor == null ? Colors.grey : labelColor,
            fontWeight: fontWeight == null ? FontWeight.normal : fontWeight,
          ),
        ),
      ],
    );
  }
}

class DropDownIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;

  DropDownIcon({this.icon, this.iconSize, this.iconColor});

  @override
  Widget build(BuildContext context) {
    var block = SizeConfig.block;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          icon == null ? Icons.keyboard_arrow_down_sharp : icon,
          size: iconSize == null ? block * 5.5 : iconSize,
          color: iconColor == null ? Colors.grey : iconColor,
        ),
        SizedBox(width: block * 2)
      ],
    );
  }
}

class DropDownError extends StatelessWidget {
  final String errorText;
  final double paddingLeft;
  final double paddingTop;
  final Color errorColor;

  DropDownError({this.errorText, this.paddingLeft, this.paddingTop, this.errorColor});

  @override
  Widget build(BuildContext context) {
    var block = SizeConfig.block;
    return Container(
      padding: EdgeInsets.only(left: paddingLeft == null ? 0 : paddingLeft),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: paddingTop == null ? 0 : paddingTop),
          Text(errorText, style: TextStyle(color: errorColor == null ? Colors.red : errorColor, fontSize: block * 3)),
        ],
      ),
    );
  }
}
