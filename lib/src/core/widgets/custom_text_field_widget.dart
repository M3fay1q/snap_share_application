import 'package:snap_share_application/src/core/utils/app_colors.dart';
import 'package:snap_share_application/src/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixIcon;
  final bool divider;
  final Color? fillColor;
  final String? initialValue;
  final Function()? tap;

  const CustomTextFieldWidget(
      {super.key,
      this.hintText = 'Write something...',
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.onSubmit,
      this.onChanged,
      this.prefixIcon,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false,
      this.divider = false,
      this.fillColor,
      this.initialValue,
      this.tap});

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          maxLines: widget.maxLines,
          onTap: () {
            if (widget.tap != null) {
              widget.tap!();
            }
          },
          controller: widget.controller,
          focusNode: widget.focusNode,
          style:
              robotoRegular.copyWith(fontSize: 16, color: AppColors.greyColor),
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ]
              : null,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: AppColors.jcTextfeildgreycolor,
            )),
            isDense: true,
            hintText: widget.hintText,
            hintStyle: robotoRegular.copyWith(
              fontSize: 14,
              color: AppColors.greyColor,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:
                        Image.asset(widget.prefixIcon!, height: 20, width: 20),
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3)),
                    onPressed: _toggle,
                  )
                : null,
          ),
          onSubmitted: (text) => widget.nextFocus != null
              ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null
                  ? widget.onSubmit!(text)
                  : null,
          onChanged: widget.onChanged,
        ),
        widget.divider
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20), child: Divider())
            : const SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
