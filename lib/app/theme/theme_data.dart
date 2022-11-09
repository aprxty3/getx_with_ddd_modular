import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryText,
    required Color indicatorTab,
    required Color labelTab,
    required Color unselectedLabelTab,
    Color? secondaryText,
    required Color accentColor,
    Color? divider,
    Color? shadowColor,
    Color? buttonBackground,
    required Color buttonText,
    Color? cardBackground,
    Color? disabled,
    required Color error,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      tabBarTheme: TabBarTheme(
        labelStyle: baseTextTheme.headline4!.copyWith(
            color: primaryText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'NunitoSans'),
        unselectedLabelStyle: baseTextTheme.headline4!.copyWith(
            color: primaryText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'NunitoSans'),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
          color: indicatorTab,
        ),
        labelColor: labelTab,
        unselectedLabelColor: unselectedLabelTab,
      ),
      brightness: brightness,
      buttonColor: buttonBackground,
      canvasColor: background,
      cardColor: background,
      dividerColor: divider,
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardTheme(
        color: cardBackground,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      backgroundColor: background,
      primaryColor: accentColor,
      accentColor: accentColor,

      textSelectionTheme: TextSelectionThemeData(
        selectionColor: accentColor,
        selectionHandleColor: accentColor,
        cursorColor: accentColor,
      ),
      toggleableActiveColor: accentColor,
      appBarTheme: AppBarTheme(
        brightness: brightness,
        color: cardBackground,
        textTheme: TextTheme(
          bodyText1: baseTextTheme.bodyText1!.copyWith(
            color: secondaryText,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(
          color: primaryText,
        ),
      ),

      iconTheme: IconThemeData(
        color: buttonBackground,
        size: 16.0,
      ),
      errorColor: error,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: accentColor,
          primaryVariant: accentColor,
          secondary: accentColor,
          secondaryVariant: accentColor,
          surface: background,
          background: background,
          error: error,
          onPrimary: buttonText,
          onSecondary: buttonText,
          onSurface: buttonText,
          onBackground: buttonText,
          onError: buttonText,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(color: error),
        labelStyle: GoogleFonts.nunitoSans(
          fontSize: 14.0,
          color: primaryText.withOpacity(0.5),
        ),
        hintStyle: TextStyle(
          color: secondaryText,
          fontSize: 12.0,
        ),
      ),
      shadowColor: shadowColor,
      // fontFamily: 'Poppins',
      unselectedWidgetColor: hexToColor('#DADCDD'),
      textTheme: GoogleFonts.nunitoSansTextTheme(baseTextTheme).copyWith(
        headline1: baseTextTheme.headline1!.copyWith(
            color: primaryText,
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'NunitoSans'),
        headline2: baseTextTheme.headline2!.copyWith(
            color: primaryText,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontFamily: 'NunitoSans'),
        headline3: baseTextTheme.headline3!.copyWith(
            color: secondaryText,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'NunitoSans'),
        headline4: baseTextTheme.headline4!.copyWith(
            color: primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'NunitoSans'),
        headline5: baseTextTheme.headline5!.copyWith(
            color: primaryText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'NunitoSans'),
        headline6: baseTextTheme.headline6!.copyWith(
            color: primaryText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'NunitoSans'),
        bodyText1: baseTextTheme.bodyText1!.copyWith(
            color: secondaryText, fontSize: 14, fontFamily: 'NunitoSans'),
        bodyText2: baseTextTheme.bodyText2!.copyWith(
            color: primaryText, fontSize: 12, fontFamily: 'NunitoSans'),
        button: baseTextTheme.button!.copyWith(
            color: primaryText,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'NunitoSans'),
        caption: baseTextTheme.caption!.copyWith(
            color: ColorConstants.unselectedButtonColor,
            fontSize: 11.0,
            fontWeight: FontWeight.w300,
            fontFamily: 'NunitoSans'),
        overline: baseTextTheme.overline!.copyWith(
            color: secondaryText,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'NunitoSans'),
        subtitle1: baseTextTheme.subtitle1!.copyWith(
            color: primaryText,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'NunitoSans'),
        subtitle2: baseTextTheme.subtitle2!.copyWith(
            color: secondaryText,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'NunitoSans'),
        labelMedium: GoogleFonts.nunitoSans().copyWith(
            color: primaryText,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'NunitoSans'),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
      brightness: Brightness.light,
      background: ColorConstants.lightScaffoldBackgroundColor,
      cardBackground: ColorConstants.cardBackground,
      primaryText: ColorConstants.lightTextColor,
      secondaryText: Colors.white,
      accentColor: ColorConstants.secondaryAppColor,
      indicatorTab: Colors.white,
      unselectedLabelTab: ColorConstants.primaryColor,
      labelTab: ColorConstants.primaryColor,
      divider: ColorConstants.lightGray,
      buttonBackground: ColorConstants.primaryColor,
      buttonText: ColorConstants.secondaryAppColor,
      disabled: ColorConstants.secondaryAppColor,
      error: Colors.red,
      shadowColor: ColorConstants.backgroundShadowColor);

  static ThemeData get darkTheme => createTheme(
      brightness: Brightness.dark,
      background: ColorConstants.darkScaffoldBackgroundColor,
      cardBackground: ColorConstants.darkCardBackground,
      primaryText: ColorConstants.darkTextColor,
      secondaryText: Colors.black,
      accentColor: ColorConstants.secondaryDarkAppColor,
      indicatorTab: Colors.black,
      labelTab: Colors.white,
      unselectedLabelTab: Colors.white,
      divider: Colors.black45,
      buttonBackground: ColorConstants.primaryColor,
      buttonText: ColorConstants.secondaryDarkAppColor,
      disabled: ColorConstants.secondaryDarkAppColor,
      error: Colors.red,
      shadowColor: ColorConstants.darkShadowColor);
}
