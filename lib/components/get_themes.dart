import 'package:flutter/material.dart';


class AppTheme {
  AppTheme._();

  
   static Color HexColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color appDarkColor=AppTheme.HexColor('#eb3349');
  static Color appLightColor=AppTheme.HexColor('#f45c43');
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static  Color nearlyDarkBlue = Colors.blue;

  static  Color nearlyBlue = Colors.blueAccent;
  static const Color nearlyBlack = Colors.black87;
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText =  Colors.black87;
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

 static  Color appColor =Colors.blueAccent;
 static const TextStyle inpuStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  static const TextStyle hintStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0, color: Colors.grey);
 static const  String appName="Vinter";

static const Color GreyBackground = Color.fromRGBO(249, 252, 255, 1);
  static const Color GreyBorder = Color.fromRGBO(207, 207, 207, 1);
  
  static const Color GreenLight = Color.fromRGBO(93, 230, 26, 1);
  static const Color GreenDark = Color.fromRGBO(57, 170, 2, 1);
  static const Color GreenIcon = Color.fromRGBO(30, 209, 2, 1);
  static const Color GreenAccent = Color.fromRGBO(30, 209, 2, 1);
  static const Color GreenShadow = Color.fromRGBO(30, 209, 2, 0.24); // 24%
  static const Color GreenBackground = Color.fromRGBO(181, 255, 155, 0.36); // 36%

  static const Color OrangeIcon = Color.fromRGBO(236, 108, 11, 1);
  static const Color OrangeBackground = Color.fromRGBO(255, 208, 155, 0.36); // 36%

  static const Color PurpleLight = Color.fromRGBO(248, 87, 195, 1);
  static const Color PurpleDark = Color.fromRGBO(224, 19, 156, 1);
  static const Color PurpleIcon = Color.fromRGBO(209, 2, 99, 1);
  static const Color PurpleAccent = Color.fromRGBO(209, 2, 99, 1);
  static const Color PurpleShadow = Color.fromRGBO(209, 2, 99, 0.27); // 27%
  static const Color PurpleBackground = Color.fromRGBO(255, 155, 205, 0.36); // 36%

  static const Color DeeppurlpleIcon = Color.fromRGBO(191, 0, 128, 1);
  static const Color DeeppurlpleBackground = Color.fromRGBO(245, 155, 255, 0.36); // 36%

  static const Color BlueLight = Color.fromRGBO(126, 182, 255, 1);
  static const Color BlueDark = Color.fromRGBO(95, 135, 231, 1);
  static const Color BlueIcon = Color.fromRGBO(9, 172, 206, 1);
  static const Color BlueBackground = Color.fromRGBO(155, 255, 248, 0.36); // 36%
  static const Color BlueShadow = Color.fromRGBO(104, 148, 238, 1);

  static const Color HeaderBlueLight = Color.fromRGBO(129, 199, 245, 1);
  static const Color HeaderBlueDark = Color.fromRGBO(56, 103, 213, 1);
  static const Color HeaderGreyLight = Color.fromRGBO(225, 255, 255, 0.31); // 31%

  static const Color YellowIcon = Color.fromRGBO(249, 194, 41, 1);
  static const Color YellowBell = Color.fromRGBO(225, 220, 0, 1);
  static const Color YellowAccent = Color.fromRGBO(255, 213, 6, 1);
  static const Color YellowShadow = Color.fromRGBO(243, 230, 37, 0.27); // 27%
  static const Color YellowBackground = Color.fromRGBO(255, 238, 155, 0.36); // 36%

  static const Color BellGrey = Color.fromRGBO(217, 217, 217, 1);
  static const Color BellYellow = Color.fromRGBO(255, 220, 0, 1);

  static const Color TrashRed = Color.fromRGBO(251, 54, 54, 1);
  static const Color TrashRedBackground = Color.fromRGBO(255, 207, 207, 1);
  
  static const Color TextHeader = Color.fromRGBO(85, 78, 143, 1);
  static const Color TextHeaderGrey = Color.fromRGBO(104, 104, 104, 1);
  static const Color TextSubHeaderGrey = Color.fromRGBO(161, 161, 161, 1);
  static const Color TextSubHeader = Color.fromRGBO(139, 135, 179, 1);
  static const Color TextBody = Color.fromRGBO(130, 160, 183, 1);
  static const Color TextGrey = Color.fromRGBO(198, 198, 200, 1);
  static const Color TextWhite = Color.fromRGBO(243, 243, 243, 1);
  static const Color HeaderCircle = Color.fromRGBO(255, 255, 255, 0.17);
  
  static  LinearGradient gradientBody = LinearGradient(colors: [
    AppTheme.appColor,
    Colors.red,
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  static const TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    title: title,
    subtitle: subtitle,
    body2: body2,
    body1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}

