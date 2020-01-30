import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vinter/components/get_themes.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Center(
          child: SpinKitThreeBounce(
            color: AppTheme.appLightColor,
            size: 50.0,
          ),
        ));
  }
}
