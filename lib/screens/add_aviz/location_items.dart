import 'package:aviz_app/bloc/naviagtion/navigation_bloc.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_event.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/widgets/custom_widgets/custom_checkbox.dart';
import 'package:aviz_app/widgets/custom_widgets/switch_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationItems extends StatefulWidget {
  LocationItems({super.key});

  @override
  State<LocationItems> createState() => _LocationItemsState();
}

class _LocationItemsState extends State<LocationItems> {
  final SwitchController switchController = SwitchController(switchValue: true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'موقعیت مکانی',
                    style: TextStyle(
                      fontFamily: 'sb',
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset('assets/images/icon-map.png'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'بعد انتخاب محل دقیق روی نقشه میتوانید نمایش آن را فعال یا غیر فعال کید تا حریم خصوصی شما خفظ شود.',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'sm',
                  fontSize: 14,
                  color: CustomColors.grey500,
                ),
              ),
              SizedBox(height: 32),
              GestureDetector(
                onTap: () async {},
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 184,
                        child: Image.asset(
                          'assets/images/background-map.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 190,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.red,
                            padding: EdgeInsets.only(left: 8, right: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-gps.png')),
                            SizedBox(width: 12),
                            Flexible(
                              child: Text(
                                'گرگان، صیاد شیرازی آبادانی',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: 'sm',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              CustomCheckbox(
                title: 'موقعیت دقیق نقشه نمایش داده شود؟',
                // defaultCheck: true,
                controller: switchController,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                onPressed: () {
                  context.read<NavigationBloc>().add(navigateToNextPageEvent());
                },
                child: Text(
                  'بعدی',
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
