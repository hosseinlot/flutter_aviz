import 'dart:async';

import 'package:aviz_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class SmsVerifyScreen extends StatefulWidget {
  const SmsVerifyScreen({super.key});

  @override
  State<SmsVerifyScreen> createState() => _SmsVerifyScreenState();
}

class _SmsVerifyScreenState extends State<SmsVerifyScreen> {
  int _seconds = 59;
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 59;
      _startTimer();
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 76),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'تایید شماره موبایل',
                    style: TextStyle(
                      fontFamily: 'sb',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'کد ورود پیامک شده را وارد کنید',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'sm',
                  fontSize: 14,
                  color: CustomColors.grey500,
                ),
              ),
              SizedBox(height: 46),
              Center(
                child: Pinput(
                  defaultPinTheme: PinTheme(
                    width: 86,
                    height: 50,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'sb',
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.grey300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onCompleted: (pin) => print(pin),
                  errorTextStyle: TextStyle(
                    color: CustomColors.red,
                  ),
                  // validator: (value) {
                  //   return value == '1111' ? null : 'کد وارد شده اشتباه است';
                  // },
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_seconds == 0) {
                        _resetTimer();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            content: Text(
                              'کد جدید به شماره شما پیامک شد، لطفا آن را وارد نمایید',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'sb',
                                fontSize: 12,
                                color: CustomColors.red,
                              ),
                            ),
                            duration: Duration(seconds: 2),
                            backgroundColor: CustomColors.grey100,
                          ),
                        );
                      }
                    },
                    child: Text(
                      'ارسال مجدد کد',
                      style: TextStyle(
                        fontFamily: 'sb',
                        fontSize: 14,
                        color: _seconds == 0 ? CustomColors.red : CustomColors.grey400,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '00:${_seconds}',
                    style: TextStyle(
                      fontFamily: 'sb',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/icon-arrow-left.png'),
                        SizedBox(width: 16),
                        Text(
                          'تایید ورود',
                          style: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
