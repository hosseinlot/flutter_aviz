import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/widgets/custom_widgets/switch_controller.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({super.key, required this.title, required this.controller});

  final String title;
  final SwitchController controller;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.controller.toggleSwitch();
        });
      },
      child: Container(
        width: double.infinity,
        height: 48,
        margin: EdgeInsets.only(top: 24),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: CustomColors.grey300)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 46,
              width: 46,
              child: FittedBox(
                child: Switch(
                  value: widget.controller.switchValue,
                  activeColor: Colors.white,
                  activeTrackColor: CustomColors.red,
                  inactiveTrackColor: CustomColors.grey400,
                  inactiveThumbColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      widget.controller.toggleSwitch();
                    });
                  },
                ),
              ),
            ),
            Center(
              child: Text(
                '${widget.title}',
                style: TextStyle(
                  fontFamily: 'sm',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
