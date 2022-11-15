import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/feature/core/presentation/sign_in/sign_in_logic.dart';

import '../reset_password/reset_password_ui.dart';

class SignInUi extends StatelessWidget {
  static const String namePath = '/sign-in';
  final logic = Get.find<SignInLogic>();
  final state = Get.find<SignInLogic>().state;

  SignInUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _logo(),
          _textField('user'),
          _textField('pass'),
          _button('sign in'),
          _button('forget pass'),
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
        controller: name == 'user'
            ? state.usernameController.value
            : state.passwordController.value,
        obscureText: name == 'user' ? false : true,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          hintText: name == 'user' ? 'Username' : 'Password',
          hintStyle: const TextStyle(fontSize: 14, color: Colors.red),
        ),
      ),
    );
  }

  _button(String name) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: name == 'sign in' ? Colors.amber : Colors.grey,
      ),
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: () => name == 'sign in'
            ?
            //TODO : you can use function like this to provide the API
            logic.signIn()
            : Get.toNamed(ResetPasswordUi.namePath),
        child: Text(
          name == 'sign in' ? 'Sign In' : 'Forget Password',
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}
