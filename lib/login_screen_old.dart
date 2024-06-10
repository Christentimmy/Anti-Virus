import 'package:antivirus/color.dart';
import 'package:flutter/material.dart';
import 'common_textfield.dart'; // assuming CustomTextField is defined here
import 'scan.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // 5% padding horizontally
          vertical: screenHeight * 0.05, // 5% padding vertically
        ),
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/ant.png",
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.2, // 40% of screen width
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // 1% of screen height
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: screenWidth * 0.05, // 5% of screen width
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.005), // 0.5% of screen height
              Text(
                "SignIn to continue",
                style: TextStyle(
                  fontSize: screenWidth * 0.015, // 1.5% of screen width
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // 3% of screen height
              CustomTextField(
                hintText: "Email",
                controller: _emailController,
                isObscureText: false,
                icon: Icons.email,
                activeColor: AppConfig.primaryColor,
              ),
              SizedBox(height: screenHeight * 0.01), // 1% of screen height
              CustomTextField(
                hintText: "Password",
                controller: _passwordController,
                isObscureText: true,
                icon: Icons.lock,
                activeColor: AppConfig.primaryColor,
              ),
              SizedBox(height: screenHeight * 0.005), // 0.5% of screen height
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: screenWidth * 0.015, // 1.5% of screen width
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // 3% of screen height
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
                    color: Colors
                        .blue, // Changed to a blue color for demonstration
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: screenWidth * 0.02, // 2% of screen width
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // 3% of screen height
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: screenWidth * 0.015, // 1.5% of screen width
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: screenWidth * 0.015, // 1.5% of screen width
                        fontWeight: FontWeight.w600,
                        color: Colors
                            .blue, // Changed to a blue color for demonstration
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
