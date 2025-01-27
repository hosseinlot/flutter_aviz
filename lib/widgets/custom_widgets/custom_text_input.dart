import 'package:aviz_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  CustomTextInput({
    super.key,
    required this.title,
    required this.placeholder,
    required this.controller,
  });

  final String title;
  final String placeholder;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    controller.text = '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'sm',
            fontSize: 14,
            color: CustomColors.grey500,
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: 159,
          child: Center(
            child: TextFormField(
              controller: controller,
              validator: (value) => value == '' ? 'نمی تواند خالی باشد' : null,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'sm', fontSize: 16),
              decoration: InputDecoration(
                fillColor: CustomColors.grey200, // Set your desired color
                filled: true,
                hintText: placeholder,
                hintTextDirection: TextDirection.rtl,
                hintStyle: TextStyle(fontFamily: 'sm', fontSize: 16, color: Colors.grey[400]),
                border: InputBorder.none,
                errorStyle: TextStyle(
                  fontFamily: 'dana',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
