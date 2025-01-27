import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/utils/settings_manager.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var showHotAviz = SettingsManager.loadSettings()['showHotAviz'];
  var showAvizAlert = SettingsManager.loadSettings()['showAvizAlert'];
  var showPhoneNumber = SettingsManager.loadSettings()['showPhoneNumber'];
  var showSeperateWidgets = SettingsManager.loadSettings()['showSeperateWidgets'];

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
              'تنظیمات',
              style: TextStyle(fontFamily: 'sb', fontSize: 20, color: CustomColors.red),
            ),
            SizedBox(width: 6),
            SizedBox(width: 28, height: 28, child: Image.asset('assets/images/aviz-logo.png', fit: BoxFit.contain)),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showHotAviz = !showHotAviz;
                  SettingsManager.saveSettings('showHotAviz', showHotAviz);
                });
              },
              child: Container(
                width: double.infinity,
                height: 48,
                margin: EdgeInsets.only(top: 24),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: CustomColors.grey300)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 46,
                      width: 46,
                      child: FittedBox(
                        child: Switch(
                          value: showHotAviz,
                          activeColor: Colors.white,
                          activeTrackColor: CustomColors.red,
                          inactiveTrackColor: CustomColors.grey400,
                          inactiveThumbColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              showHotAviz = !showHotAviz;
                              SettingsManager.saveSettings('showHotAviz', showHotAviz);
                            });
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'نمایش آویز های پین شده',
                        style: TextStyle(
                          fontFamily: 'sm',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  showAvizAlert = !showAvizAlert;
                  SettingsManager.saveSettings('showAvizAlert', showAvizAlert);
                });
              },
              child: Container(
                width: double.infinity,
                height: 48,
                margin: EdgeInsets.only(top: 24),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: CustomColors.grey300)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 46,
                      width: 46,
                      child: FittedBox(
                        child: Switch(
                          value: showAvizAlert,
                          activeColor: Colors.white,
                          activeTrackColor: CustomColors.red,
                          inactiveTrackColor: CustomColors.grey400,
                          inactiveThumbColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              showAvizAlert = !showAvizAlert;
                              SettingsManager.saveSettings('showAvizAlert', showAvizAlert);
                            });
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'نمایش هشدار آویز ها',
                        style: TextStyle(
                          fontFamily: 'sm',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  showSeperateWidgets = !showSeperateWidgets;
                  SettingsManager.saveSettings('showSeperateWidgets', showSeperateWidgets);
                });
              },
              child: Container(
                width: double.infinity,
                height: 48,
                margin: EdgeInsets.only(top: 24),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: CustomColors.grey300)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 46,
                      width: 46,
                      child: FittedBox(
                        child: Switch(
                          value: showSeperateWidgets,
                          activeColor: Colors.white,
                          activeTrackColor: CustomColors.red,
                          inactiveTrackColor: CustomColors.grey400,
                          inactiveThumbColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              showSeperateWidgets = !showSeperateWidgets;
                              SettingsManager.saveSettings('showSeperateWidgets', showSeperateWidgets);
                            });
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'نمایش جزئیات بصورت جداگونه',
                        style: TextStyle(
                          fontFamily: 'sm',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  showPhoneNumber = !showPhoneNumber;
                  SettingsManager.saveSettings('showPhoneNumber', showPhoneNumber);
                });
              },
              child: Container(
                width: double.infinity,
                height: 48,
                margin: EdgeInsets.only(top: 24),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: CustomColors.grey300)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 46,
                      width: 46,
                      child: FittedBox(
                        child: Switch(
                          value: showPhoneNumber,
                          activeColor: Colors.white,
                          activeTrackColor: CustomColors.red,
                          inactiveTrackColor: CustomColors.grey400,
                          inactiveThumbColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              showPhoneNumber = !showPhoneNumber;
                              SettingsManager.saveSettings('showPhoneNumber', showPhoneNumber);
                            });
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'نمایش شماره تلفن من',
                        style: TextStyle(
                          fontFamily: 'sm',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
