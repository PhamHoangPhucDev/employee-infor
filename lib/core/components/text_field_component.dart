import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class TextFieldComponent extends StatefulWidget {
  TextFieldComponent({super.key,required this.label,required this.controller,this.hintText="Nhập giá trị",this.isPassword = false,this.maxLines});
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final int? maxLines;

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword; // nếu là password thì ẩn mặc định
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,style: AppTypography.body()),
        SizedBox(height: 8,),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          style: AppTypography.body(color: AppColors.primary),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTypography.body(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(
                color: AppColors.border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(
                color: AppColors.border,
              ),
            ),
            suffixIcon: widget.isPassword?IconButton(
              onPressed: (){
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: HugeIcon(
                icon: _obscureText ? HugeIcons.strokeRoundedViewOff : HugeIcons.strokeRoundedView,
                color: AppColors.primary,
              ),
            ):null,
            filled: true,
            fillColor: AppColors.backgroundInput,
          ),
          maxLines: widget.isPassword ? 1 : widget.maxLines,
        ),  
      ],
    );
  }
}