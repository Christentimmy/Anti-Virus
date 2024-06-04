import 'package:antivirus/common_textfield.dart';
import 'package:antivirus/scan.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewPadding.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.14),
                Center(
                  child: Image.asset(
                    "assets/images/ant.png",
                    width: 200,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: "Full Name",
                  controller: _fullNameController,
                  isObscureText: false,
                  icon: Icons.person,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: "Email",
                  controller: _emailController,
                  isObscureText: false,
                  icon: Icons.email,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: "Password",
                  controller: _passwordController,
                  isObscureText: false,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: "Confirm Password",
                  controller: _confirmPasswordController,
                  isObscureText: false,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ScanScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
