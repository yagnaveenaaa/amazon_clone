import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/resources/authentication.dart';
import 'package:amazon_clone/screens/sign_up_screen.dart';
import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/custom_main_button.dart';
import 'package:amazon_clone/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');
  bool isLoading = false;

  final AuthenticationMethods authenticationMethods = AuthenticationMethods();

  @override
  void dispose() {
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(amazonLogo, height: screenSize.height * 0.10),
                    Container(
                      width: screenSize.width > 600
                          ? screenSize.width * 0.3
                          : screenSize.width * 0.8,
                      height: screenSize.height * 0.6,
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
                            "Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 28),
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
                              "Sign In",
                              style: TextStyle(
                                  letterSpacing: 0.6, color: blackColor),
                            ),
                            color: orangeColor,
                            isLoading: isLoading,
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });

                              String result =
                                  await authenticationMethods.signIpUser(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim());
                              if (result == 'success') {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ScreenLayout()));
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Utils().showSnackBar(
                                    context: context, content: result);
                              }
                            },
                            buttonWidth: 0.5,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 1,
                          color: Colors.grey,
                        )),
                        const Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            "New to Amazon?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: Colors.grey,
                        )),
                      ],
                    ),
                    CustomMainButton(
                      child: const Text(
                        "Create an Amazon Account",
                        style: TextStyle(
                          letterSpacing: 0.6,
                          color: blackColor,
                        ),
                      ),
                      color: Colors.grey[400]!,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SignUpScreen()));
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
