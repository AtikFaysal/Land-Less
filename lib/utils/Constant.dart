
import 'package:flutter/material.dart';
import 'package:land_less/AppTheme/app_theme.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: AppTheme.nearlyBlack,
  fontWeight: FontWeight.w500,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color:AppTheme.nearlyWhite,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);