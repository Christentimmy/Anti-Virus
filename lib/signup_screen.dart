import 'package:antivirus/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:antivirus/color.dart';
import 'package:antivirus/common_textfield.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _tokenCodeController = TextEditingController();

  bool loading = false;

  void submitRegister(BuildContext context) async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Get form data
    final String fullName = _fullNameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String tokenCode = _tokenCodeController.text;

    setState(() {
      loading = true;
    });

    try {
      // Make HTTP POST request
      final response = await http.post(
        Uri.parse(
            'https://africanbuyers.mytestwebberdomain.website/register.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'full_name': fullName,
          'email': email,
          'password': password,
          'token_code': tokenCode,
        }),
      );

      // Check response status
      if (response.statusCode == 200) {
        // Parse JSON response
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Check success flag
        if (responseData['success']) {
          // Registration successful, navigate to next screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );

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
            content: Text('Failed to register. Please try again later.'),
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
      return 'Please enter your email';
    }
    final RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? validateTokenCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the token code';
    }
    return null;
  }

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
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
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
                            "Create Account",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Sign up to get started",
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            hintText: "Full Name",
                            controller: _fullNameController,
                            isObscureText: false,
                            icon: Icons.person,
                            activeColor: AppConfig.primaryColor,
                            validator: validateFullName,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: "Apple ID Mail",
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
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: "Confirm Password",
                            controller: _confirmPasswordController,
                            isObscureText: true,
                            icon: Icons.lock,
                            activeColor: AppConfig.primaryColor,
                            validator: validateConfirmPassword,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: "Token Code",
                            controller: _tokenCodeController,
                            isObscureText: false,
                            icon: Icons.lock,
                            activeColor: AppConfig.primaryColor,
                            validator: validateTokenCode,
                          ),
                          const SizedBox(height: 40),
                          if (loading) ...{
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          } else ...{
                            GestureDetector(
                              onTap: () => submitRegister(context),
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppConfig.primaryColor,
                                ),
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          },
                          const SizedBox(height: 30),
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
