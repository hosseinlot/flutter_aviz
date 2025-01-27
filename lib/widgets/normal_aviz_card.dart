import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/data/model/aviz.dart';
import 'package:aviz_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class NormalAvizCard extends StatelessWidget {
  NormalAvizCard({
    super.key,
    required this.aviz,
  });
  final Aviz aviz;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 139,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 40,
            spreadRadius: -30,
            offset: Offset(0.0, 10),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 111,
            height: 107,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: (aviz.thumbnail == null)
                      ? Image.asset('assets/images/image-placholder.png')
                      : CachedImage(imageUrl: aviz.thumbnail),
                )),
          ),
          SizedBox(
            width: 215,
            height: 107,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  aviz.title,
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 14,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Text(
                  'سال ساخت ۱۳۹۸، سند تک برگ، دوبلکس تجهیزات کامل',
                  style: TextStyle(
                    fontFamily: 'sm',
                    fontSize: 12,
                    color: CustomColors.grey500,
                    height: 1.8,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.grey100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          '۸٬۲۰۰٬۰۰۰٬۰۰۰',
                          style: TextStyle(fontFamily: 'sb', fontSize: 12, color: CustomColors.red),
                        ),
                      ),
                    ),
                    Text(
                      'قیمت:',
                      style: TextStyle(
                        fontFamily: 'sb',
                        fontSize: 14,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
