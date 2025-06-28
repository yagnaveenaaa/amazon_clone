import 'dart:developer';

import 'package:amazon_clone/resources/authentication.dart';
import 'package:amazon_clone/screens/sign_in_screen.dart';
import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/custom_main_button.dart';
import 'package:amazon_clone/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController addressController =
      TextEditingController(text: '');
  bool loading = false;

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.network(amazonLogo, height: screenSize.height * 0.09),
                    SizedBox(
                      height: screenSize.height * 0.7,
                      child: FittedBox(
                        child: Container(
                          width: screenSize.width > 600
                              ? screenSize.width * 0.3
                              : screenSize.width * 0.8,
                          height: screenSize.height * 0.7,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 28),
                              ),
                              CustomTextFieldWidet(
                                title: "Name",
                                controller: nameController,
                                obsecure: false,
                                type: TextInputType.text,
                                hintText: 'Enter your name',
                              ),
                              CustomTextFieldWidet(
                                title: "Address",
                                controller: addressController,
                                obsecure: false,
                                type: TextInputType.text,
                                hintText: 'Enter your address',
                              ),
                              CustomTextFieldWidet(
                                title: "Email",
                                controller: emailController,
                                obsecure: false,
                                type: TextInputType.text,
                                hintText: 'Enter your email',
                              ),
                              CustomTextFieldWidet(
                                title: "Password",
                                controller: passwordController,
                                obsecure: true,
                                type: TextInputType.text,
                                hintText: 'Enter your password',
                              ),
                              CustomMainButton(
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      letterSpacing: 0.6, color: blackColor),
                                ),
                                color: orangeColor,
                                isLoading: loading,
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  String result = await AuthenticationMethods()
                                      .signUpUser(
                                          name: nameController.text.trim(),
                                          address:
                                              addressController.text.trim(),
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim());

                                  if (result == "success") {
                                    setState(() {
                                      loading = false;
                                      Utils().showSnackBar(
                                          context: context,
                                          content: "Registration successfull");
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SignInScreen()));
                                  } else {
                                    setState(() {
                                      loading = false;
                                      Utils().showSnackBar(
                                          context: context, content: result);
                                    });
                                  }
                                },
                                buttonWidth: 0.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CustomMainButton(
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          letterSpacing: 0.6,
                          color: blackColor,
                        ),
                      ),
                      color: Colors.grey[400]!,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SignInScreen()));
                      },
                      buttonWidth: screenSize.width > 600 ? 0.3 : 0.7,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
