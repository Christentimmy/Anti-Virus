import 'package:flutter/material.dart';
import 'package:antivirus/color.dart';
import 'package:antivirus/common_textfield.dart';
import 'package:antivirus/scan.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isWideScreen)
                Expanded(
                  flex: 1,
                  child: Container(
                    color: AppConfig
                        .primaryColor, // Adjust background color as needed
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Join Antivirus Guard Today",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Protect your system from online threats with Antivirus Guard. Create your account now and experience the peace of mind that comes with our advanced security features.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: isWideScreen ? 1 : 2,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/ant.png",
                            width: 120,
                            height: 120,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Sign up to get started",
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 30),
                        CustomTextField(
                          hintText: "Full Name",
                          controller: _fullNameController,
                          isObscureText: false,
                          icon: Icons.person,
                          activeColor: AppConfig.primaryColor,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hintText: "Email",
                          controller: _emailController,
                          isObscureText: false,
                          icon: Icons.email,
                          activeColor: AppConfig.primaryColor,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hintText: "Password",
                          controller: _passwordController,
                          isObscureText: false,
                          icon: Icons.lock,
                          activeColor: AppConfig.primaryColor,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hintText: "Confirm Password",
                          controller: _confirmPasswordController,
                          isObscureText: false,
                          icon: Icons.lock,
                          activeColor: AppConfig.primaryColor,
                        ),
                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const ScanScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppConfig.primaryColor,
                            ),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
