import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/modules/home/views/home_view.dart';
import 'package:talabang_mandau/app/modules/tabDecider/views/tab_decider_view.dart';
import 'package:talabang_mandau/app/widgets/button.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  @override
  LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(
        children: [
          iconContent(),
          SizedBox(
            height: 48,
          ),
          buildForm(
            context,
          )
        ],
      )),
    );
  }

  Widget iconContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 64,
        ),
        SizedBox(
          height: 160,
          child: Image.asset(
            "assets/icon/logo_telabang_icon.png",
            fit: BoxFit.cover,
          ),
        ),
        CText(
          "Telabang Mandau\nNusantara",
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 24,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildForm(context) {
    return Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 48),
        child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Username Field
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    controller: loginController.usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  // Password Field
                  Obx(
                    () => TextFormField(
                      controller: loginController.passwordController,
                      obscureText: loginController.isPassword.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Kata Sandi',
                        suffixIcon: IconButton(
                          icon: loginController.isPassword.value
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(Icons.visibility_off),
                          onPressed: () => loginController.isPassword.value =
                              !loginController.isPassword.value,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kata sandi tidak boleh kosong';
                        }
                        if (value.length < 6) {
                          return 'Kata sandi harus lebih dari 6 karakter';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      CText("Lupa Password?"),
                      CText(
                        " Hubungi Helpdesk",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E8BE1),
                      ),
                    ],
                  ),
                  SizedBox(height: 36),
                  PrimaryButton(
                    text: "Masuk",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        loginController.login();
                        // Get.off(() => TabDeciderView());
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Form valid')),
                        // );
                      }
                    },
                  )
                ])));
  }

  Widget buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }
}
