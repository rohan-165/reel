import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reel/core/constants/typedef.dart';
import 'package:reel/core/extension/build_context_extension.dart';

import '../constants/app_colors.dart';

InputDecoration inputDecoration({
  VoidCallbackWithValue<bool>? passwordCallBack,
  required BuildContext context,
  String? labelText,
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool isPassword = false,
  TextStyle? hintStyle,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(
      15.w,
      10.w,
      8.w,
      10.w,
    ),
    labelText: labelText,
    labelStyle: context.textTheme.bodySmall!.copyWith(
      color: AppColors.greyColor,
    ),
    hintText: hintText,
    prefixIcon: prefixIcon,
    hintStyle: hintStyle ??
        context.textTheme.bodySmall!.copyWith(
          color: AppColors.greyColor,
        ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.lightGreyColor,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(5.r),
      ),
    ),
    errorStyle: context.textTheme.bodySmall!.copyWith(
      color: AppColors.errorColor,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.errorColor,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(5.r),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.lightGreyColor,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(5.r),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.lightGreyColor,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(5.r),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.greyColor,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(5.r),
      ),
    ),
    suffixIcon: isPassword
        ? PasswordSuffixIcon(
            passwordCallBack: passwordCallBack,
          )
        : suffixIcon,
  );
}

class PasswordSuffixIcon extends StatefulWidget {
  final VoidCallbackWithValue<bool> passwordCallBack;

  const PasswordSuffixIcon({super.key, this.passwordCallBack});

  @override
  State<PasswordSuffixIcon> createState() => _PasswordSuffixIconState();
}

class _PasswordSuffixIconState extends State<PasswordSuffixIcon> {
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
      ),
      onPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
        widget.passwordCallBack!(_isPasswordVisible);
      },
    );
  }
}
