import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LockieThemes {

  static final roundedInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: Colors.grey[800]!,
    ),
    borderRadius: BorderRadius.circular(5)
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: Color(0xff0a0a0a),
    dialogBackgroundColor: Color(0xff0a0a0a),
    backgroundColor: Color(0xff1c1c1c),
    fontFamily: 'Manrope',
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark
      ),
      backgroundColor: Colors.white,
      elevation: 2
    ),
    iconTheme: IconThemeData(
      color: Colors.white70
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: roundedInputBorder,
      errorBorder: roundedInputBorder,
      enabledBorder: roundedInputBorder,
      focusedBorder: roundedInputBorder,
      disabledBorder: roundedInputBorder,
      focusedErrorBorder: roundedInputBorder,
      contentPadding: const EdgeInsets.all(5),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.grey[400]
      ),
      headline4: TextStyle(
        fontSize: 40,
        color: Colors.grey[400],
        fontWeight: FontWeight.w700,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700
      ),
      headline6: TextStyle(
        color: Colors.transparent,
        fontWeight: FontWeight.w600,
        shadows: [
          Shadow(
            color: Colors.grey[200]!,
            offset: Offset(0, -8)
          )      
        ],
        decoration: TextDecoration.underline,
        decorationColor: Colors.grey[200],
        decorationThickness: 1.5
      ),
      button: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      )
    )
  );

  static ThemeData website = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    scaffoldBackgroundColor: Color(0xff0a0a0a),
    dialogBackgroundColor: Color(0xff0a0a0a),
    backgroundColor: Color(0xff1c1c1c),
    fontFamily: 'Manrope',
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark
      ),
      backgroundColor: Colors.white,
      elevation: 2
    ),
    iconTheme: IconThemeData(
      color: Colors.white70
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: roundedInputBorder,
      errorBorder: roundedInputBorder,
      enabledBorder: roundedInputBorder,
      focusedBorder: roundedInputBorder,
      disabledBorder: roundedInputBorder,
      focusedErrorBorder: roundedInputBorder,
      contentPadding: const EdgeInsets.all(5),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.grey[400]
      ),
      headline2: TextStyle(
        fontWeight: FontWeight.w300
      ),
      button: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      )
    )
  );
}