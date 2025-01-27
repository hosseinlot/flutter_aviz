import 'package:flutter/material.dart';

class WarningScreen extends StatelessWidget {
  const WarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // elevation: 1,
        automaticallyImplyLeading: false,
        actions: [
          Text(
            'زنگ خطرهای قبل از معامله',
            style: TextStyle(
              fontFamily: 'dana',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-appbar-arrow-right.png')),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('روش‌های رایج کلاهبرداری در وسایل نقلیه',
                          style: TextStyle(fontFamily: 'dana', fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 14),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- دریافت بیعانه', style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- فروش وسیله نقلیه دارای ایراد فنی',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- فروش لوازم جانبی تقلبی یا معیوب',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      SizedBox(height: 14),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('توصیه می‌کنیم:',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16, fontWeight: FontWeight.bold))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- از پرداخت بیعانه خارج از دیوار بپرهیزید',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- قبل از معامله از کارشناس معتمد خود کمک بگیرید',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      SizedBox(height: 48),
                      Text('روش‌های رایج کلاهبرداری در املاک',
                          style: TextStyle(fontFamily: 'dana', fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 14),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- دریافت بیعانه', style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- فروش وسیله نقلیه دارای ایراد فنی',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- فروش لوازم جانبی تقلبی یا معیوب',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      SizedBox(height: 14),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('توصیه می‌کنیم:',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16, fontWeight: FontWeight.bold))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- از پرداخت بیعانه خارج از دیوار بپرهیزید',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- قبل از معامله از کارشناس معتمد خود کمک بگیرید',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      SizedBox(height: 48),
                      Text('روش‌های رایج کلاهبرداری در موبایل',
                          style: TextStyle(fontFamily: 'dana', fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 14),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- دریافت بیعانه', style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- فروش وسیله نقلیه دارای ایراد فنی',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- فروش لوازم جانبی تقلبی یا معیوب',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      SizedBox(height: 14),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('توصیه می‌کنیم:',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16, fontWeight: FontWeight.bold))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- از پرداخت بیعانه خارج از دیوار بپرهیزید',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                      Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('- قبل از معامله از کارشناس معتمد خود کمک بگیرید',
                              style: TextStyle(fontFamily: 'dana', fontSize: 16))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
