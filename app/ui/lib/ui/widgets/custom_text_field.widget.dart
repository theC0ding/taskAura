import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autovalidateMode,
    this.focusNode,
    this.helperText,
    this.textStyle,
    this.inputFormatters,
    this.onSuffixIconTap, // Custom action on tapping the suffix icon
    this.enabled = true, // New parameter for controlling the disabled state
    this.errorStyle, // Style for the error text
    this.helperStyle, // Style for the helper text
  });

  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final String? helperText;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback?
      onSuffixIconTap; // New callback for suffix icon tap action
  final bool enabled; // New flag to control whether the field is enabled or not
  final TextStyle? errorStyle; // New field for custom error text style
  final TextStyle? helperStyle; // New field for custom helper text style

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _isObscure = false;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autovalidateMode: widget.autovalidateMode,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled, // Control whether the field is enabled
      style: widget.textStyle ??
          TextStyle(color: Theme.of(context).colorScheme.onSurface),
      decoration: _buildInputDecoration(context),
      cursorColor: Theme.of(context).colorScheme.primary,
    );
  }

  /// Builds the input decoration with label, hint, prefix/suffix icons, etc.
  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      labelText: widget.labelText,
      labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
      hintText: widget.hintText,
      hintStyle:
          TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
      enabledBorder: _buildInputBorder(Theme.of(context).colorScheme.outline),
      focusedBorder: _buildInputBorder(Theme.of(context).colorScheme.primary),
      errorBorder: _buildInputBorder(Theme.of(context).colorScheme.error),
      disabledBorder: _buildInputBorder(Theme.of(context)
          .colorScheme
          .onSurface
          .withOpacity(0.5)), // Disabled border
      fillColor: Theme.of(context).colorScheme.surface,
      filled: true,
      prefixIcon: _buildPrefixIcon(context),
      suffixIcon: _buildSuffixIcon(context),
      errorText: widget.errorText,
      errorStyle: widget.errorStyle, // Apply custom error style
      helperText: widget.helperText,
      helperStyle: widget.helperStyle, // Apply custom helper text style
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    );
  }

  /// Builds the border for the text field depending on the state (enabled, focused, error)
  OutlineInputBorder _buildInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: borderColor),
    );
  }

  /// Builds the prefix icon, if provided
  Widget? _buildPrefixIcon(BuildContext context) {
    if (widget.prefixIcon == null) return null;
    return Icon(widget.prefixIcon,
        color: Theme.of(context).colorScheme.primary);
  }

  /// Builds the suffix icon, with handling for the password visibility toggle or custom action
  Widget? _buildSuffixIcon(BuildContext context) {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).colorScheme.primary),
        onPressed: widget.onSuffixIconTap ??
            _toggleObscureText, // Custom tap action or default toggle
      );
    } else if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(widget.suffixIcon,
            color: Theme.of(context).colorScheme.primary),
        onPressed:
            widget.onSuffixIconTap, // Custom action when tapping suffix icon
      );
    }
    return null;
  }
}
