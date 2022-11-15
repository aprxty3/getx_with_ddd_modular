import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/feature/main/presentation/profile_page/profile_page_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/presentation/sign_in/sign_in_ui.dart';
import 'main_home_page_logic.dart';

class MainHomePageUi extends StatelessWidget {
  static const String namePath = '/home-page';
  final logic = Get.find<MainHomePageLogic>();
  final state = Get.find<MainHomePageLogic>().state;

  MainHomePageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _header(),
          _buttonNavigation('profile'),
          _buttonNavigation('back'),
        ],
      ),
    );
  }

  _header() {
    return Container(
      width: Get.width,
      height: 300,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        color: Colors.blueAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _profilePic(),
          _descProfile('name'),
          _descProfile('job'),
        ],
      ),
    );
  }

  _profilePic() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, top: 30),
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage('https://picsum.photos/200'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _descProfile(String name) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 200,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Center(
        child: Obx(() {
          return Text(
            name == 'name' ? state.nameProfile.value : state.jobProfile.value,
            style: GoogleFonts.nunitoSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: name == 'name' ? Colors.red : Colors.amber,
            ),
          );
        }),
      ),
    );
  }

  _buttonNavigation(String to) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: 400,
      height: 50,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(24),
      //   color: to == 'profile' ? Colors.grey : Colors.greenAccent,
      // ),
      child: TextButton(
        onPressed: () {
          to == 'profile'
              ? Get.toNamed(ProfilePageUi.namePath)
              : Get.offAndToNamed(SignInUi.namePath);
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: to == 'profile' ? Colors.grey : Colors.greenAccent,
        ),
        child: Text(
          to == 'profile' ? 'To Profile Page' : 'Back to Sign In',
          style: GoogleFonts.nunitoSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: to == 'profile' ? Colors.black : Colors.red,
          ),
        ),
      ),
    );
  }
}
