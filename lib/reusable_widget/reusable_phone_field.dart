import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common_utils/constants.dart';
import '../common_utils/validator.dart';
import 'reusable_inputdecoration.dart';
import 'reusable_textformfield.dart';

bool focus = false;

class ReusablePhoneField extends StatefulWidget {
  const ReusablePhoneField(
      {super.key,
      this.margin,
      this.controller,
      this.emptyMassage,
      this.enabled,
      this.keyBoardType,
      this.maxLine,
      this.hinText,
      this.onchange,
      this.validation,
      required this.textCapitalization,
      this.onFieldSubmitted,
      this.focusNode,
      this.fieldLength,
      this.suffixString,
      this.suffixStyle,
      this.suffixIcon,
      this.height,
      this.editable,
      this.autoFocus,
      this.style,
      this.maxLength,
      required this.obscureText,
      this.flagEmoji,
      this.hintStyle,
      this.validator,
      this.fillColor,
      this.borderColor,
      required this.countryCode});

  final EdgeInsets? margin;
  final TextEditingController? controller;
  final String? emptyMassage;
  final bool? enabled;
  final ValueChanged? onchange;
  final TextInputType? keyBoardType;
  final int? maxLine;
  final String? suffixString;
  final String? hinText;
  final String? Function(String?)? validation;
  final TextCapitalization textCapitalization;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? fieldLength;
  final TextStyle? suffixStyle;
  final Widget? suffixIcon;
  final bool obscureText;
  final double? height;
  final bool? editable;
  final bool? autoFocus;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxLength;
  final String? flagEmoji;
  final FormFieldValidator<String?>? validator;
  final Color? fillColor;
  final Color? borderColor;
  final String countryCode;
  @override
  State<ReusablePhoneField> createState() => ReusablePhoneFieldState();
}

class ReusablePhoneFieldState extends State<ReusablePhoneField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(
              left: 15.0.sp, top: 16.0.sp, bottom: 16.0.sp, right: 15.0.sp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Theme.of(context).dividerColor, width: 1.5)),
          child: Center(
              child: Text(
            Constants.countryCode,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )),
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: SizedBox(
            child: ReusableTextFormField(
              borderColor: widget.borderColor ?? const Color(0xffD4D9DE),
              fillColor: widget.fillColor ?? Colors.white.withOpacity(0.65),
              controller: widget.controller,
              keyBoardType: TextInputType.phone,
              validator: (value) => Validators.validateMobile(value.toString()),
              inputDecoration:
                  textfieldInputDecoration(context, widget.hinText ?? ''),
              hinText: widget.hinText ?? '0000000000',
              hintStyle: widget.hintStyle,
              style: widget.style ??
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textCapitalization: TextCapitalization.characters,
              obscureText: false,
              fieldLength: widget.fieldLength,
              onchange: widget.onchange,
              onFieldSubmitted: widget.onFieldSubmitted,
            ),
          ),
        ),
      ],
    );
  }
}
