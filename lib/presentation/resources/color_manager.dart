import 'package:flutter/material.dart';

class ColorManager{
  static Color primary = HexColor.fromHex("#40ADEF");
  static Color darkGrey = HexColor.fromHex("#393D3f");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHex("#0091EA");
  static Color background = HexColor.fromHex("#FBFBFE");
  static Color subtitle = HexColor.fromHex("#7B7B7B");
  static Color splashTitle = HexColor.fromHex("#671F1F");

  //New Colors

  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color lightBlue = HexColor.fromHex("#b7d7f7");
  static Color error = HexColor.fromHex("#e61f34"); //red color

}

extension HexColor on Color{
  static Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll('#', '');
    if(hexColorString.length == 6){
      hexColorString = "FF" +hexColorString; //Appending characters for opacity of 100% at start of HexCode
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}