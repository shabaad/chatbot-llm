import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

bool focus = false;

class ReusableTextFormField extends StatefulWidget {
  const ReusableTextFormField(
      {super.key,
      this.margin,
      this.controller,
      this.emptyMassage,
      this.enabled,
      this.keyBoardType,
      this.maxLine,
      this.minLine,
      this.hinText,
      this.onchange,
      this.validation,
      required this.textCapitalization,
      this.onFieldSubmitted,
      this.focusNode,
      this.fieldLength,
      this.suffixString,
      this.fillColor,
      this.borderColor,
      this.suffixStyle,
      this.suffixIcon,
      this.height,
      this.editable,
      this.autoFocus,
      this.style,
      this.hintStyle,
      this.maxLength,
      this.obscureText = false,
      this.validator,
      this.containerWidth,
      this.inputDecoration,
      this.readonly});

  final EdgeInsets? margin;
  final TextEditingController? controller;
  final String? emptyMassage;
  final bool? enabled;
  final ValueChanged? onchange;
  final TextInputType? keyBoardType;
  final int? maxLine;
  final int? minLine;
  final String? suffixString;
  final Color? fillColor;
  final Color? borderColor;
  final String? hinText;
  final String? Function(String?)? validation;
  final TextCapitalization textCapitalization;
    final Function(String)? onFieldSubmitted;

  final FocusNode? focusNode;
  final List<TextInputFormatter>? fieldLength;
  final TextStyle? suffixStyle;
  final Widget? suffixIcon;
  final bool? obscureText;
  final double? height;
  final bool? editable;
  final bool? autoFocus;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxLength;
  final FormFieldValidator<String?>? validator;
  final double? containerWidth;
  final bool? readonly;
  final InputDecoration? inputDecoration;

  @override
  State<ReusableTextFormField> createState() => ReusableTextFormFieldState();
}

class ReusableTextFormFieldState extends State<ReusableTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly:widget.readonly?? false,
      textCapitalization: widget.textCapitalization,
      enabled: widget.enabled,
      onChanged: widget.onchange,
      obscureText: widget.obscureText ?? false,
      validator: widget.validator ??
          ((value) {
            if (value == null || value.isEmpty) {
              return widget.emptyMassage ?? "Fields are empty";
            } else {
              return null;
            }
          }),
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: widget.focusNode,
      style: widget.style ??
         TextStyle(fontSize: 15,color: AppColors.black,fontWeight: FontWeight.bold),
      autofocus: widget.autoFocus ?? false,
      enableInteractiveSelection: widget.editable ?? true,
      maxLines: widget.maxLine ?? 1,
      minLines: widget.minLine,
      controller: widget.controller,
      keyboardType: widget.keyBoardType,
      inputFormatters: widget.fieldLength,
      textInputAction: TextInputAction.next,
      decoration: widget.inputDecoration ??
          InputDecoration(
              fillColor: widget.fillColor ?? Colors.white.withOpacity(0.65),
              filled: true,
              isDense: true,
              suffixText: widget.suffixString,
              counterText: "",
              hintStyle:
                  widget.hintStyle ?? AppTextStyle.greyDisabledText16w600,
              suffixIconColor: Colors.red,
              suffixStyle: widget.suffixStyle,
              hintText: widget.hinText,
              suffixIcon: widget.suffixIcon,
              contentPadding: EdgeInsets.only(
                  left: 20.0.sp, top: 16.0.sp, bottom: 16.0.sp),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.sp)),
                borderSide: BorderSide(
                  width: 1.sp,
                  color: widget.borderColor ??
                      const Color.fromRGBO(217, 217, 217, 0.96),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.sp)),
                borderSide: BorderSide(
                  width: 1.sp,
                  color: widget.borderColor ??
                      const Color.fromRGBO(217, 217, 217, 0.96),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.sp)),
                borderSide: BorderSide(
                  width: 1.sp,
                  color: widget.borderColor ??
                      const Color(0xFFF44336),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.sp)),
                borderSide: BorderSide(
                  width: 1.sp,
                  color: widget.borderColor ??
                      const Color.fromRGBO(217, 217, 217, 0.96),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.sp)),
                borderSide: BorderSide(
                  width: 1.sp,
                  color: widget.borderColor ??
                      const Color.fromRGBO(217, 217, 217, 0.96),
                ),
              ),
              border: const OutlineInputBorder(),
              labelStyle: const TextStyle(
                color: Colors.grey,
              )),
      maxLength: widget.maxLength,
    );
  }
}
