import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_palette.dart';

class QelemTheme {
  static ThemeData qelemTheme = ThemeData(
    textTheme: TextTheme(
      button: GoogleFonts.comfortaa(),
      headline5: GoogleFonts.comfortaa(),
      headline6: GoogleFonts.comfortaa(),
      subtitle2: GoogleFonts.comfortaa(color: Colors.black.withOpacity(0.6)),
      bodyText2: GoogleFonts.comfortaa(color: Colors.black87),
      bodyText1: GoogleFonts.comfortaa(color: Colors.black87),
    ),
    primaryTextTheme: TextTheme(
      button: GoogleFonts.comfortaa(),
      headline1: GoogleFonts.comfortaa(),
      headline2: GoogleFonts.comfortaa(),
      headline3: GoogleFonts.comfortaa(),
      headline4: GoogleFonts.comfortaa(),
      headline5: GoogleFonts.comfortaa(),
      headline6: GoogleFonts.comfortaa(),
      subtitle2: GoogleFonts.comfortaa(),
      bodyText2: GoogleFonts.comfortaa(),
      bodyText1: GoogleFonts.comfortaa(),
    ),
    primarySwatch: AppPalette.qelemPurple,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPalette.qelemPurple,
      selectedLabelStyle: const TextStyle(color: Colors.white),
      unselectedLabelStyle: TextStyle(color: Colors.white.withOpacity(0.75)),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.75),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      titleTextStyle:
          GoogleFonts.comfortaa(color: Colors.white, fontSize: 20.0),
      actionsIconTheme: IconThemeData(
        color: Colors.white.withOpacity(0.75),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Colors.black12, width: 1)),
    ),
    listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.all(0),
        horizontalTitleGap: 2,
        minVerticalPadding: 2),
    buttonTheme: ButtonThemeData(
      buttonColor: AppPalette.qelemPurple,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
    ),
  );
}
