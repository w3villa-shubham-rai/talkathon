import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talkathon/core/theme/app_pallet.dart';
import 'package:talkathon/utils/padding_marging.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  final TextStyle? textStyle;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool? showCursor;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? prefixText;
  final Widget? suffix;
  final Widget? prefix;
  final bool? obscureText;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final Color? fillColors;
  final String? label;
  final double? height;
  final double? width;
  final bool ? required;
  final String? requiredText;
  final Color ? requiredColors;
  final TextInputType? keyboardType;
  // final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Widget? labelRowWidget;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? labelMargin;
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? prefixIconConstraints;
  final FocusNode? focusNode;
  final Color? borderColor;

  const CustomTextFormField({super.key,
    this.hintText,
    this.hintStyle,
    required this.controller,
    this.validator,
    this.textStyle,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.showCursor = true,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.suffix,
    this.prefix,
    this.prefixText,
    this.obscureText = false,
    this.borderRadius,
    this.borderSide,
    this.fillColors,
    this.label,
    this.height,
    this.width,
    this.required = false,
    this.requiredText,
    this.requiredColors,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.labelRowWidget = const SizedBox.shrink(),
    this.onChanged,
    // this.inputFormatters,
    this.labelStyle,
    this.labelMargin,
    this.contentPadding,
    this.prefixIconConstraints,
    this.focusNode,
    this.borderColor,
  });

  final BorderRadius borderRadiusAll = const BorderRadius.all(Radius.circular(18));
  final BorderSide borderSideAll = const BorderSide(color: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label != null ? Row(
              children: [
                Container(
                  margin: labelMargin ?? const EdgeInsets.only(left: 16, bottom: 0),
                  child: Text(
                    "$label",
                    style: labelStyle ?? const TextStyle(color: AppColors.blackColor, fontSize: 12),
                  ),
                ),
                labelRowWidget != null ? labelRowWidget!.marginOnly(left: 6) : const SizedBox.shrink()
              ],
            ) : const SizedBox.shrink(),
            required == true ? Text(
              requiredText ?? "(Optional)",
              style: TextStyle(color: requiredColors == Colors.transparent ? AppColors.greyColor : requiredColors, fontSize: 11),
            ).marginOnly(right: 10, bottom: 0) : const SizedBox.shrink(),
          ],
        ),
        SizedBox(
          height: height ?? 46,
          width: width,
          child: TextFormField(
            focusNode: focusNode,
            maxLength: maxLength,
            textAlign: textAlign!,
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            validator: validator,
            style: textStyle,
            maxLines: maxLines,
            showCursor: showCursor,
            readOnly: readOnly!,
            obscureText: obscureText!,
            keyboardType: keyboardType,
            // inputFormatters: inputFormatters ?? [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))],
            decoration: InputDecoration(
              isDense: true,
              fillColor: fillColors,
              filled: true,

              // border: OutlineInputBorder(
              //   borderSide: BorderSide(color: borderColor ?? AppColors.cobaltBlue),
              //
              // ),
              // enabledBorder: OutlineInputBorder(
              //   borderSide: borderSide ?? borderSideAll,
              //   borderRadius: borderRadius ?? borderRadiusAll,
              // ),
              // errorBorder: OutlineInputBorder(
              //   borderSide: borderSide ?? borderSideAll,
              //   borderRadius: borderRadius ?? borderRadiusAll,
              // ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.cobaltBlue), // Set focused border color to cobaltBlue
                borderRadius: borderRadius ?? borderRadiusAll,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color:AppColors.cobaltBlue), //<-- SEE HERE
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: borderSide ?? borderSideAll,
                borderRadius: borderRadius ?? borderRadiusAll,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: borderSide ?? borderSideAll,
                borderRadius: borderRadius ?? borderRadiusAll,
              ),

              prefixText: prefixText,
              prefixStyle: const TextStyle(color: Colors.black, fontSize: 14),
              hintText: hintText ?? "",
              hintStyle: hintStyle ?? const TextStyle(color: AppColors.lightGrey, fontSize: 12),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              prefix: prefix,
              suffix: suffix,
              contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: (46) / 2 - 12.0, horizontal: 16.0),
              prefixIconConstraints: prefixIconConstraints ?? const BoxConstraints(minWidth: 14, maxHeight: 16, maxWidth: 16, minHeight: 14),
            ),
            onTap: () {
              onTap != null ? onTap!.call() : () {};
            },
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
