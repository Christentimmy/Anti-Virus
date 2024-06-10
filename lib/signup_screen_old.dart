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
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, // 5% padding horizontally
            vertical: screenHeight * 0.05, // 5% padding vertically
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: screenHeight * 0.4), // 14% of screen height
                Center(
                  child: Image.asset(
                    "assets/images/ant.png",
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.2, // 40% of screen width
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // 1% of screen height
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // 5% of screen width
                    fontWeight: FontWeight.bold,
                    color: AppConfig.primaryColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // 3% of screen height
                CustomTextField(
                  hintText: "Full Name",
                  controller: _fullNameController,
                  isObscureText: false,
                  icon: Icons.person,
                  activeColor: AppConfig.primaryColor,
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height
                CustomTextField(
                  hintText: "Apple ID Mail",
                  controller: _emailController,
                  isObscureText: false,
                  icon: Icons.email,
                  activeColor: AppConfig.primaryColor,
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height
                CustomTextField(
                  hintText: "Password",
                  controller: _passwordController,
                  isObscureText: false,
                  icon: Icons.lock,
                  activeColor: AppConfig.primaryColor,
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height
                CustomTextField(
                  hintText: "Confirm Password",
                  controller: _confirmPasswordController,
                  isObscureText: false,
                  icon: Icons.lock,
                  activeColor: AppConfig.primaryColor,
                ),
                SizedBox(height: screenHeight * 0.04), // 4% of screen height
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ScanScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: screenHeight * 0.06, // 6% of screen height
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppConfig.primaryColor,
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: screenWidth * 0.02, // 2% of screen width
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03), // 3% of screen height
              ],
            ),
          ),
        ),
      ),
    );
  }
}
