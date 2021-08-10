import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageLoader extends StatelessWidget {
  final Color color;
  final double size;
  ImageLoader({this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitPulse(color: color, size: size, duration: Duration(milliseconds: 1000));
  }
}
