// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reel/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? lable;
  final Color? backgroundColor;
  final Function() onTap;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;
  final bool isLoading;

  const CustomButton({
    super.key,
    this.lable,
    this.backgroundColor,
    required this.onTap,
    this.textStyle,
    this.padding,
    this.borderColor,
    this.textColor,
    this.fontSize,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 20.w,
            ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: borderColor ?? AppColors.blueAccentColor,
            ),
          ),
          borderRadius: BorderRadius.circular(4.r),
          color: backgroundColor ?? AppColors.blueAccentColor,
        ),
        child: isLoading
            ? CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.whiteColor,
              )
            : Text(
                lable ?? 'Submit',
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize ?? 18.sp,
                ),
              ),
      ),
    );
  }
}
