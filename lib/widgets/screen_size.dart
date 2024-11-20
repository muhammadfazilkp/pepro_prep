import 'package:flutter/material.dart';

class ScreenSize {
  static late MediaQueryData _queryData;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double width;
  static late double height;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static void init(BuildContext context) {
    _queryData = MediaQuery.of(context);
    width = _queryData.size.width;
    height = _queryData.size.height;
    blockSizeHorizontal = width / 100;
    blockSizeVertical = height / 100;
    _safeAreaHorizontal = _queryData.padding.left + _queryData.padding.right;
    _safeAreaVertical = _queryData.padding.top + _queryData.padding.bottom;
    safeBlockHorizontal = (width - _safeAreaHorizontal) / 100;
    safeBlockVertical = (height - _safeAreaVertical) / 100;
  }
}
