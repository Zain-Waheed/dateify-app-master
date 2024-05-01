

  import 'package:flutter/cupertino.dart';

class AppTextStyle {

  // static TextStyle dosis (Color color, double fs, FontWeight fw,)
  // {
  //   return GoogleFonts.dosis(
  //     fontSize: fs,
  //     color: color,
  //     fontWeight: fw,
  //   );
  // }
  static TextStyle ModernEra (Color color, double fs, FontWeight fw,)
  {
    return TextStyle(
      fontFamily: 'ModernEra',
      fontSize: fs,
      color: color,
      fontWeight: fw,
    );
  }
  static TextStyle ModernEraLight (Color color, double fs, FontWeight fw,)
  {
    return TextStyle(
      fontFamily: 'ModernEra-Light',
      fontSize: fs,
      color: color,
      fontWeight: fw,
    );
  }
  static TextStyle ModernEraMedium (Color color, double fs, FontWeight fw,)
  {
    return TextStyle(
      fontFamily: 'ModernEra-Medium',
      fontSize: fs,
      color: color,
      fontWeight: fw,
    );
  }
}