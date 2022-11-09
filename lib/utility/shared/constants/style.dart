import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class StyleConstants {
  static const bold = FontWeight.w700;
  static const semiBold = FontWeight.w600;
  static const medium = FontWeight.w500;
  static const regular = FontWeight.w400;
  static const light = FontWeight.w300;

  static var stylePrimaryButton = ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 30),
    primary: const Color(0xff52c4c5),
    onPrimary: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shadowColor: Colors.white,
    elevation: 6,
    enableFeedback: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 15.44,
      fontFamily: "Nunito Sans",
      fontWeight: FontWeight.w500,
    ),
  );

  static const heading1Text = TextStyle(
    color: Color(0xff333333),
    fontSize: 14,
    fontFamily: "Nunito Sans",
    fontWeight: FontWeight.w700,
  );

  static const appBarText = TextStyle(
    color: Color(0xff333333),
    fontSize: 18,
    fontFamily: "Nunito Sans",
    fontWeight: FontWeight.w700,
  );

  //APPBAR
  static TextStyle kAppBarTextStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: ColorConstants.kBlack,
    fontStyle: FontStyle.normal,
  );

//ONBOARD PAGE
  static TextStyle mainTextStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle secondTextStyle = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle nextStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static TextStyle skipStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: const Color(0xffC4C4C4),
  );

//SIGN IN PAGE
  static TextStyle signIn1style = GoogleFonts.poppins(
    fontSize: 27,
    fontWeight: FontWeight.w400,
  );

  static TextStyle salahStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.red,
  );

  static TextStyle rememberMeStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.kBlack,
  );

  static TextStyle forgetPassStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xff007AFF),
  );

  static TextStyle loginStyle = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w800,
    color: ColorConstants.kWhite,
  );

  static TextStyle loginStyleNegative = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.black,
  );

  static TextStyle haventAccounStyle2 = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: const Color(0xff007AFF),
  );

//MAINPAGE
  static TextStyle mainTitleStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

//CHATPAGE

  static TextStyle nameUserStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kBlack,
  );

  static TextStyle chatUserStyle = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kGrey,
  );

//INCHAT PAGE

  static TextStyle inChatNameStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kBlack,
  );

  static TextStyle statusStyle = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kGrey,
  );

//FRIEND PROFILE
  static TextStyle mainFriendStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kBlack,
  );

  static TextStyle jobFriendStyle = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kBlack,
  );

  static TextStyle labelFriendStyle1 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kBlack,
  );

  static TextStyle labelFriendStyle2 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kBlack,
  );

  static TextStyle labelFriendStyle3 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kGrey,
  );

  static TextStyle contactInfoFriendStyle = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kBlack,
  );

//MEDIAPAGE

  static TextStyle mediaTitleStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kBlack,
  );

//DOCUMENTPAGE

  static TextStyle documentTitleStyle1 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kBlack,
  );

  static TextStyle documentTitleStyle2 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kBlack,
  );

//LINKEDPAGE

  static TextStyle linkedTitleStyle = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: ColorConstants.kBlack,
  );

//LABEL PAGE
  static TextStyle labelStyle1 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kBlack,
  );

  static TextStyle labelStyle2 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: ColorConstants.kGrey,
  );

  static TextStyle logCallUserStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.kBlack,
    fontStyle: FontStyle.normal,
  );

  static TextStyle logCallStatusStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.kGrey,
    fontStyle: FontStyle.normal,
  );

//PROFILE PAGE

  static TextStyle contactStyle1 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: ColorConstants.kBlack,
    fontStyle: FontStyle.normal,
  );

  static TextStyle contactStyle2 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstants.kBlack,
  );

  static TextStyle contactStyle3 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.red,
  );

  static TextStyle settingStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

//DOCUMENT PAGE

  static TextStyle docStyle1 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.kBlack,
    // height: 21,
  );

  static TextStyle docStyle2 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.kBlack,
    // height: 18,
  );

  static TextStyle docStyle3 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstants.kBlack,
    // height: 15,
  );

  static TextStyle docStyle4 = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: ColorConstants.kLineDark,
    // height: 15,
  );

//NEWS PAGE

  static TextStyle newsMainStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: ColorConstants.kBlack,
  );

  static TextStyle newStyle1 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstants.kBlack,
  );

  static TextStyle newStyle2 = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: ColorConstants.kBlack,
  );
}
