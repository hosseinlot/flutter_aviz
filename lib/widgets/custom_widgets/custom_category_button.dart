import 'package:aviz_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomCategoryButton extends StatelessWidget {
  CustomCategoryButton({
    super.key,
    required this.title,
    this.color = CustomColors.red,
    this.icon,
  });

  final String title;
  final Color color;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/icon-arrow-left.png',
            color: color,
          ),
          Spacer(),
          Text(
            title,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'sm',
            ),
          ),
          if (icon != null)
            Row(
              children: [
                SizedBox(width: 8),
                SizedBox(child: icon),
              ],
            )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(width: 1, color: CustomColors.grey200),
      ),
    );
  }
}
