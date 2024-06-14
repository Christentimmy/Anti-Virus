import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:antivirus/color.dart';
import 'package:antivirus/common_textfield.dart';
import 'package:antivirus/scan.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;

  void submitLogin(BuildContext context) async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String email = _emailController.text;
    final String password = _passwordController.text;

    setState(() {
      loading = true;
    });

    try {
      // Make HTTP POST request
      final response = await http.post(
        Uri.parse('https://africanbuyers.mytestwebberdomain.website/login.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      // Check response status
      if (response.statusCode == 200) {
        // Parse JSON response
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Check success flag
        if (responseData['success']) {
          // Registration successful, navigate to next screen
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => const ScanScreen(),
          //   ),
          // );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(responseData['message'] ?? 'Successfully Received'),
            ),
          );
          setState(() {
            loading = false;
          });
        } else {
          // Registration failed, show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(responseData['message'] ?? 'Operation failed'),
            ),
          );
          setState(() {
            loading = false;
          });
        }
      } else {
        // Server returned an error response
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to Login. Please try again later.'),
          ),
        );
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      // Error occurred during HTTP request
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error occurred. Please try again later.'),
        ),
      );
      setState(() {
        loading = false;
      });
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Secure Your System with Antivirus Guard",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Welcome to Antivirus Guard, your trusted companion in keeping your system safe from malware, viruses, and other online threats. With our advanced security features and real-time scanning, you can browse the web, download files, and use your device with peace of mind.",
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
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
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
                          const SizedBox(height: 20),
                          const Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Sign in to continue",
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            hintText: "Email",
                            controller: _emailController,
                            isObscureText: false,
                            icon: Icons.email,
                            activeColor: AppConfig.primaryColor,
                            validator: validateEmail,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: "Password",
                            controller: _passwordController,
                            isObscureText: true,
                            icon: Icons.lock,
                            activeColor: AppConfig.primaryColor,
                            validator: validatePassword,
                          ),
                          // SizedBox(height: 10),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: Text(
                          //     "Forgot Password?",
                          //     style: TextStyle(
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 30),
                          if (loading) ...{
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          } else ...{
                            GestureDetector(
                              onTap: () => submitLogin(context),
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppConfig
                                      .primaryColor, // Adjust button color as needed
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          },
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: 16,
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
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppConfig
                                        .primaryColor, // Adjust link color as needed
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
