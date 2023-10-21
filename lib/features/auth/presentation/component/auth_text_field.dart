import 'package:flutter/material.dart';
import 'package:survey_app/core/theme/color.dart';
import 'package:survey_app/core/theme/typo.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key,
      required this.label,
      required this.hint,
      this.onChanged,
      this.errorText,
      this.suffixIcon,
      this.obscure = false});

  final String label;
  final String hint;
  final bool obscure;
  final Function(String)? onChanged;
  final String? errorText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.regular12
              .copyWith(fontSize: 13, color: AppColor.subText),
        ),
        const SizedBox(height: 5),
        SizedBox(
          // height: 36,
          child: TextFormField(
            style: AppTypography.regular.copyWith(fontSize: 15),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
              // isDense: true,
              hintText: hint,
              hintStyle: AppTypography.regular
                  .copyWith(fontSize: 15, color: AppColor.secondaryText),
              errorText: errorText,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: AppColor.secondary)),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: AppColor.secondary),
              ),
              suffixIcon: suffixIcon,
            ),
            onChanged: onChanged,
            obscureText: obscure,
          ),
        )
      ],
    );
  }
}
