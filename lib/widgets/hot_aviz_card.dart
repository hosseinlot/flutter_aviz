import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/data/model/aviz.dart';
import 'package:aviz_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class HotAvizCard extends StatelessWidget {
  HotAvizCard({
    super.key,
    required this.aviz,
  });
  final Aviz aviz;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 224,
      height: 267,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 35,
            spreadRadius: -20,
            offset: Offset(0.0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              width: double.infinity,
              height: 120,
              child: FittedBox(
                fit: BoxFit.cover,
                child: (aviz.thumbnail == null)
                    ? Image.asset('assets/images/image-placholder.png')
                    : CachedImage(imageUrl: aviz.thumbnail),
              ),
            ),
          ),
          SizedBox(height: 16),
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
            'ویو عالی، سند تک برگ، سال ساخت ۱۴۰۲، تحویل فوری',
            style: TextStyle(
              fontFamily: 'sm',
              fontSize: 12,
              color: CustomColors.grey500,
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
                    '۲۵٬۶۸۳٬۰۰۰٬۰۰۰',
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
    );
  }
}
