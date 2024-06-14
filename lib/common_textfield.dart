import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final int? maxline;
  final TextEditingController controller;
  final bool isObscureText;
  final IconData icon;
  final TextInputAction? action;
  final TextInputType? type;
  final VoidCallback? suffixTap;
  final IconData? suffixICon;
  final String? Function(String?)? validator; // Changed here

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isObscureText,
    required this.icon,
    this.suffixTap,
    this.suffixICon,
    this.action,
    this.type,
    this.validator, // Changed here
    this.maxline,
    required Color activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 14),
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return "Field is required";
            }
            return null;
          },
      obscureText: isObscureText,
      maxLines: maxline ?? 1,
      textAlign: TextAlign.start,
      textInputAction: action ?? TextInputAction.done,
      keyboardType: type,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          fontSize: 13,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        labelText: hintText,
        prefixIcon: Icon(
          icon,
          size: 18,
          color: Colors.blue.withOpacity(0.6),
        ),
        suffixIcon: suffixICon != null
            ? IconButton(
                onPressed: suffixTap,
                icon: Icon(
                  suffixICon,
                  size: 18,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.blue,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.redAccent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
