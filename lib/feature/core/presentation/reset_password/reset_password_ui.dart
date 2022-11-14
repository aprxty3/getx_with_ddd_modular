import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'reset_password_logic.dart';

class ResetPasswordUi extends StatelessWidget {
  static const String namePath = '/reset-pass';
  final logic = Get.find<ResetPasswordLogic>();
  final state = Get.find<ResetPasswordLogic>().state;

  ResetPasswordUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _logo(),
          _textField('pass'),
          _textField('reType'),
          _button(),
        ],
      ),
    );
  }

  _logo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: 300,
      height: 200,
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Kasih Logo atau apa gitu biar enak dilihat',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  _textField(String name) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: TextFormField(
        obscureText: name == 'pass' ? false : true,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          hintText: name == 'pass' ? 'Password' : 'Retype Password',
          hintStyle: const TextStyle(fontSize: 14, color: Colors.blue),
        ),
      ),
    );
  }

  _button() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.amber,
      ),
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: () => logic.resetPass(),
        child: const Text(
          'Reset Password',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}
