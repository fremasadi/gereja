import 'package:flutter/material.dart';
import 'package:gereja/app/data/constants/const_color.dart';

class InputTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isSecureField;
  final bool autoCorrect;
  final String? hint;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validation;
  final double hintTextSize;
  final bool enable;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final int maxLines;

  const InputTextFormField({
    super.key,
    required this.controller,
    this.isSecureField = false,
    this.autoCorrect = false,
    this.enable = true,
    this.hint,
    this.validation,
    this.contentPadding,
    this.textInputAction,
    this.hintTextSize = 14,
    this.onFieldSubmitted,
    this.maxLines = 1,
  });

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  bool _passwordVisible = false;

  // Toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isSecureField && !_passwordVisible,
      enableSuggestions: !widget.isSecureField,
      autocorrect: widget.autoCorrect,
      validator: widget.validation ?? (_) => null,
      // Default null validation
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.enable,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: ConstColor.white,
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: widget.hintTextSize,
        ),
        contentPadding: widget.contentPadding ?? const EdgeInsets.all(16.0),
        // Default padding
        suffixIcon: widget.isSecureField
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black87,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.0,
          ),
        ),
      ),
    );
  }
}
