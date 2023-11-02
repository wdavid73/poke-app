import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poke_app/utils/responsive.dart';

class InputCustom extends StatelessWidget {
  final Responsive responsive;
  final double? inputWidth;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final String? initialValue;
  final String? prefixText;
  final bool isPassword;
  final bool isPasswordField;
  final bool withPrefixIcon;
  final bool toUpperCase;
  final bool enabled;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final void Function()? showPassword;
  final void Function(String text)? onChange;
  final void Function(String text)? onFieldSubmitted;
  final String? Function(String? text)? validator;
  final Color fillColor;
  final InputBorder? borderStyle;
  final bool isLoading;

  const InputCustom({
    Key? key,
    required this.responsive,
    required this.labelText,
    required this.hintText,
    this.onChange,
    this.validator,
    this.prefixIcon,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.withPrefixIcon = false,
    this.showPassword,
    this.isPasswordField = false,
    this.controller,
    this.inputWidth,
    this.toUpperCase = false,
    this.enabled = true,
    this.initialValue,
    this.prefixText,
    this.fillColor = Colors.white,
    this.borderStyle,
    this.onFieldSubmitted,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderInput = borderStyle ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black45,
          ),
        );
    return Container(
      width: inputWidth ?? responsive.wp(80),
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isLoading ? 2 : 0),
            child: Opacity(
              opacity: isLoading ? 0.3 : 1,
              child: TextFormField(
                initialValue: initialValue,
                textAlign: textAlign,
                maxLines: 1,
                enabled: enabled,
                keyboardType: keyboardType,
                obscureText: isPassword,
                style: TextStyle(
                  fontSize: responsive.dp(1.6),
                  color: Colors.black,
                ),
                onChanged: onChange,
                onFieldSubmitted: onFieldSubmitted,
                validator: validator,
                decoration: InputDecoration(
                  prefixText: prefixText,
                  prefixIcon: prefixIcon,
                  suffixIcon: isPasswordField
                      ? IconButton(
                          onPressed: () => showPassword!(),
                          icon: Icon(
                            isPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.lightBlueAccent,
                          ),
                        )
                      : null,
                  enabledBorder: borderInput,
                  filled: true,
                  fillColor: fillColor,
                  focusColor: Colors.white70,
                  focusedBorder: borderInput,
                  border: borderInput,
                  labelText: labelText,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.dp(1.6),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.dp(1.6),
                  ),
                ),
                controller: controller,
                inputFormatters: toUpperCase ? [UpperCaseTextFormatter()] : [],
              ),
            ),
          ),
          isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                    color: Colors.cyanAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
