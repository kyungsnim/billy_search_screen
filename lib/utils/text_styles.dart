import 'package:billy_search_screen/utils/utils.dart';
import 'package:flutter/material.dart';

/// font size
double largeFontSize = 24;
double mediumFontSize = 16;
double smallFontSize = 14;
double eventItemBrandFontSize = 11;
double eventItemTitleFontSize = 12;
double eventItemPriceFontSize = 12;
double eventItemRateFontSize = 12;


/// text style
TextStyle hintTextStyle =
    TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: mediumFontSize);

TextStyle largeTextStyle =
    TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: largeFontSize);
TextStyle mediumTextStyle =
    TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: mediumFontSize);
TextStyle smallTextStyle =
    TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: smallFontSize);

TextStyle eventItemBrandTextStyle =
    TextStyle(color: Colors.black87, fontSize: eventItemBrandFontSize, fontWeight: FontWeight.bold);
TextStyle eventItemTitleTextStyle =
TextStyle(color: Colors.black87, fontSize: eventItemTitleFontSize);
TextStyle eventItemPriceTextStyle =
TextStyle(color: Colors.black, fontSize: eventItemPriceFontSize, fontWeight: FontWeight.bold);
TextStyle eventItemRateTextStyle =
TextStyle(color: Colors.white, fontSize: eventItemRateFontSize, fontWeight: FontWeight.bold);

TextStyle moreInfoTextStyle =
TextStyle(color: baseColor, fontSize: smallFontSize, fontWeight: FontWeight.bold);

TextStyle noEventItemTextStyle =
TextStyle(color: unUsableColor, fontSize: smallFontSize,);