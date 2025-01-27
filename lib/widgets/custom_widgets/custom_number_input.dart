import 'package:aviz_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomNumberInput extends StatefulWidget {
  CustomNumberInput({
    super.key,
    required this.defaultNumber,
    required this.defaultTitle,
    required this.controller,
  });
  final int defaultNumber;
  final String defaultTitle;
  final TextEditingController controller;

  @override
  State<CustomNumberInput> createState() => _CustomNumberInputState();
}

class _CustomNumberInputState extends State<CustomNumberInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${widget.defaultTitle}',
          style: TextStyle(
            fontFamily: 'sm',
            fontSize: 14,
            color: CustomColors.grey500,
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: 159,
          // height: 48,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: CustomColors.grey200,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8,
                    height: 8,
                    child: GestureDetector(
                      onTap: () {
                        int number = int.parse(widget.controller.text);
                        if (number >= 0) {
                          widget.controller.text = (++number).toString();
                        }
                      },
                      child: Image.asset(
                        'assets/images/custom-number-input-arrow-up.png',
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      int number = int.parse(widget.controller.text);
                      if (number > 0) {
                        widget.controller.text = (--number).toString();
                      }
                    },
                    child: SizedBox(
                      width: 8,
                      height: 8,
                      child: Image.asset(
                        'assets/images/custom-number-input-arrow-down.png',
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  validator: (value) => value == '' ? 'نمی تواند خالی باشد' : null,
                  controller: widget.controller,
                  onChanged: (value) {
                    widget.controller.text = value;
                  },
                  style: TextStyle(
                    fontFamily: 'sm',
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: TextStyle(
                      fontFamily: 'sm',
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
