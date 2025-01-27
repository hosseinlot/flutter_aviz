import 'package:aviz_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: SizedBox(),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-appbar-arrow-right.png')),
            )
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'درباره آویز',
                style: TextStyle(
                  fontFamily: 'sb',
                  fontSize: 20,
                  color: CustomColors.red,
                ),
              ),
              SizedBox(width: 6),
              SizedBox(
                width: 28,
                height: 28,
                child: Image.asset(
                  'assets/images/aviz-logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('از طریق راه های ارتباطی زیر می‌توانید با صاحب اثر در تماس باشید', style: TextStyle(fontFamily: 'Dana')),
              SizedBox(height: 10),
              Text('Instagram : @hossein.lot', style: TextStyle(fontFamily: 'Dana')),
              SizedBox(height: 4),
              Text('Github : @hosseinlot', style: TextStyle(fontFamily: 'Dana')),
            ],
          ),
        ));
  }
}
