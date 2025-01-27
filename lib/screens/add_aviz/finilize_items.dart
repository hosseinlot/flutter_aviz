import 'package:aviz_app/bloc/aviz/aviz_bloc.dart';
import 'package:aviz_app/bloc/aviz/aviz_event.dart';
import 'package:aviz_app/bloc/aviz/aviz_state.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_bloc.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_event.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/data/model/field.dart';
import 'package:aviz_app/screens/add_aviz/aviz_data_temp.dart';
import 'package:aviz_app/screens/dashboard_screen.dart';
import 'package:aviz_app/widgets/custom_widgets/custom_checkbox.dart';
import 'package:aviz_app/widgets/custom_widgets/switch_controller.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flushbar/flushbar.dart';

class FinilizeItems extends StatelessWidget {
  FinilizeItems({super.key});

  final TextEditingController _titleTextEditingController = TextEditingController();
  final TextEditingController _tozihatController = TextEditingController();
  final SwitchController _chatController = SwitchController(switchValue: true);
  final SwitchController _callController = SwitchController(switchValue: false);

  @override
  Widget build(BuildContext context) {
    MultipartFile? selectedThumbnail;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          BlocListener<AvizBloc, AvizState>(
            child: Container(),
            listener: (context, state) {
              if (state is AvizAddSuccess) {
                String successResponse = state.response;
                context.read<NavigationBloc>().add(navigateToNextPageEvent());
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                        successResponse,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'sb', fontSize: 12, color: Colors.black54),
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.greenAccent),
                );
              }

              if (state is AvizAddFailed) {
                String failedResponse = state.errorMessage;
                Flushbar(
                  backgroundColor: Colors.black,
                  flushbarPosition: FlushbarPosition.BOTTOM,
                  flushbarStyle: FlushbarStyle.FLOATING,
                  dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
                  borderRadius: BorderRadius.circular(5),
                  duration: Duration(seconds: 3),
                  messageText: Text(failedResponse,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontFamily: 'sb', fontSize: 12, color: Colors.white)),
                  icon: Icon(Icons.info_outline, size: 28.0, color: Colors.white),
                  shouldIconPulse: false,
                )..show(context);
              }
            },
          ),
          CustomScrollView(
            slivers: [
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 10)),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'تصویر آویز',
                          style: TextStyle(fontFamily: 'sb', fontSize: 16),
                        ),
                        SizedBox(width: 8),
                        SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-camera.png')),
                      ],
                    ),
                    SizedBox(height: 24),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        DottedBorder(
                          strokeCap: StrokeCap.round,
                          dashPattern: [10, 5],
                          strokeWidth: 2,
                          color: CustomColors.grey300,
                          child: Container(
                            width: double.infinity,
                            height: 160,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'لطفا تصویر آویز خود را بارگذاری کنید',
                              style: TextStyle(fontFamily: 'sm', fontSize: 14, color: CustomColors.grey500),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: 160,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColors.red,
                                    padding: EdgeInsets.only(left: 16, right: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                onPressed: () async {
                                  final selectedFile = await FilePicker.platform.pickFiles(allowMultiple: false);
                                  if (selectedFile != null) {
                                    selectedThumbnail = await MultipartFile.fromFile(selectedFile.files.first.path!);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'انتخاب تصویر',
                                      style: TextStyle(fontFamily: 'sm', fontSize: 16, color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Image.asset('assets/images/icon-upload.png'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'عنوان آویز',
                          style: TextStyle(fontFamily: 'sb', fontSize: 16),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset('assets/images/icon-pencil.png'),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        controller: _titleTextEditingController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'عنوان آویز را وارد کنید',
                          hintStyle: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16,
                            color: Colors.grey[400],
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.info_outline),
                        Text(
                          'توضیحات',
                          style: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset('assets/images/icon-description.png'),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        controller: _tozihatController,
                        maxLines: 4,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: '... توضیحات آویز را وارد کنید',
                          hintStyle: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16,
                            color: Colors.grey[400],
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomCheckbox(
                      title: 'فعال کردن گفتگو',
                      controller: _chatController,
                    ),
                    CustomCheckbox(
                      title: 'فعال کردن تماس',
                      controller: _callController,
                    ),
                  ],
                ),
              ),
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 42)),
            ],
          ),
          BlocBuilder<AvizBloc, AvizState>(
            builder: (context, state) {
              Widget widget;

              if (state is AvizAddLoading) {
                widget = SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else {
                widget = Text(
                  'ثبت آگهی',
                  style: TextStyle(
                    fontFamily: 'sb',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () async {
                      AvizDataTemp.selectedFields.add(
                          Field('توضیحات', _tozihatController.text, FieldTypeEnum.TOZIHAT, FieldInputTypeEnum.TEXT));
                      context.read<AvizBloc>().add(
                            AvizAddEvent(
                              _titleTextEditingController.text,
                              AvizDataTemp.selectedCategory!.title!,
                              AvizDataTemp.selectedSubCategory!.title!,
                              AvizDataTemp.selectedThumbnail = selectedThumbnail,
                              AvizDataTemp.selectedFields,
                            ),
                          );
                    },
                    child: widget,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
