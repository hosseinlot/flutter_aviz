import 'package:another_flushbar/flushbar.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_bloc.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_event.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/data/model/category.dart';
import 'package:aviz_app/data/model/field.dart';
import 'package:aviz_app/screens/add_aviz/aviz_data_temp.dart';
import 'package:aviz_app/widgets/custom_widgets/custom_number_input.dart';
import 'package:aviz_app/widgets/custom_widgets/custom_checkbox.dart';
import 'package:aviz_app/widgets/custom_widgets/custom_text_input.dart';
import 'package:aviz_app/widgets/custom_widgets/switch_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PropertyItems extends StatefulWidget {
  PropertyItems({super.key});

  @override
  State<PropertyItems> createState() => _PropertyItemsState();
}

class _PropertyItemsState extends State<PropertyItems> {
  final GlobalKey<FormState> _propertiesFormKey = GlobalKey<FormState>();
  Category selectedCategory = AvizDataTemp.selectedCategory!;
  final List<TextEditingController> _textFieldsControllerList = [];
  final List<SwitchController> _checkboxControllerList = [];
  List<Field> textFields = [];
  List<Field> checkboxFields = [];

  @override
  void initState() {
    super.initState();
    for (var field in selectedCategory.fields) {
      if (field.type == FieldTypeEnum.MOSHAKHASAT || field.type == FieldTypeEnum.VIZHEGI || field.type == FieldTypeEnum.GHEYMAT) {
        textFields.add(field);
      } else if (field.type == FieldTypeEnum.EMKANAT) {
        checkboxFields.add(field);
      }
    }

    for (int i = 0; i < textFields.length; i++) {
      _textFieldsControllerList.add(TextEditingController(text: textFields[i].defaultValue.toString()));
    }
    for (int i = 0; i < checkboxFields.length; i++) {
      _checkboxControllerList.add(SwitchController(switchValue: checkboxFields[i].defaultValue));
    }
  }

  void saveFields() {
    // for (var field in textFields) {
    //   AvizDataTemp.selectedFields.add(Field(field.title,
    //       _textFieldsControllerList[textFields.indexOf(field)].text, field.type, field.inputType));
    // }
    // for (var field in checkboxFields) {
    //   AvizDataTemp.selectedFields.add(
    //     Field(field.title, _checkboxControllerList[checkboxFields.indexOf(field)].switchValue,
    //         field.type, field.inputType),
    //   );
    // }
    for (var field in textFields) {
      var fieldValue;

      final existingFieldIndex = AvizDataTemp.selectedFields.indexWhere((existingField) => existingField.title == field.title);
      if (existingFieldIndex != -1) {
        // Field already exists, update its value
        if (field.inputType == FieldInputTypeEnum.TEXT) {
          fieldValue = _textFieldsControllerList[textFields.indexOf(field)].text;
        } else if (field.inputType == FieldInputTypeEnum.NUMBER) {
          fieldValue = int.parse(fieldValue = _textFieldsControllerList[textFields.indexOf(field)].text);
        }
        AvizDataTemp.selectedFields[existingFieldIndex].defaultValue = fieldValue;
      } else {
        if (field.inputType == FieldInputTypeEnum.TEXT) {
          AvizDataTemp.selectedFields.add(Field(field.title, _textFieldsControllerList[textFields.indexOf(field)].text, field.type, field.inputType));
        } else if (field.inputType == FieldInputTypeEnum.NUMBER) {
          AvizDataTemp.selectedFields.add(Field(field.title, int.parse(_textFieldsControllerList[textFields.indexOf(field)].text), field.type, field.inputType));
        }
      }
    }
    //
    for (var field in checkboxFields) {
      final existingFieldIndex = AvizDataTemp.selectedFields.indexWhere((existingField) => existingField.title == field.title);
      if (existingFieldIndex != -1) {
        AvizDataTemp.selectedFields[existingFieldIndex].defaultValue = _checkboxControllerList[checkboxFields.indexOf(field)].switchValue;
      } else {
        AvizDataTemp.selectedFields.add(Field(field.title, _checkboxControllerList[checkboxFields.indexOf(field)].switchValue, field.type, field.inputType));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
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
                          'انتخاب دسته بندی آویز',
                          style: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset('assets/images/icon-category.png'),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // CustomTextInput(
                        //   title: 'محدوده ملک',
                        //   placeholder: 'خیابان صیاد شیرازی',
                        //   controller: TextEditingController(),
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'موضوع',
                              style: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 14,
                                color: CustomColors.grey500,
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: 159,
                              height: 48,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: CustomColors.grey300)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Image.asset(
                                        'assets/images/icon-arrow-down.png',
                                        color: Colors.black,
                                      ),
                                    ),
                                    Flexible(
                                      child: Center(
                                        child: Text(
                                          '${AvizDataTemp.selectedSubCategory!.title}',
                                          overflow: TextOverflow.ellipsis,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            fontFamily: 'sm',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'دسته بندی',
                              style: TextStyle(
                                fontFamily: 'sm',
                                fontSize: 14,
                                color: CustomColors.grey500,
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: 159,
                              height: 48,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: CustomColors.grey300)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Image.asset(
                                        'assets/images/icon-arrow-down.png',
                                        color: Colors.black,
                                      ),
                                    ),
                                    Flexible(
                                      child: Center(
                                        child: Text(
                                          '${AvizDataTemp.selectedCategory!.title}',
                                          overflow: TextOverflow.ellipsis,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            fontFamily: 'sm',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Divider(
                        color: CustomColors.grey200,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'ویژگی ها',
                              style: TextStyle(
                                fontFamily: 'sb',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset('assets/images/icon-properies.png'),
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Form(
                            key: _propertiesFormKey,
                            child: Wrap(
                              spacing: 40,
                              runSpacing: 30,
                              children: [
                                for (var field in textFields) ...{
                                  if (field.inputType == FieldInputTypeEnum.NUMBER) ...{
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: CustomNumberInput(
                                        defaultTitle: field.title,
                                        defaultNumber: field.defaultValue,
                                        controller: _textFieldsControllerList[textFields.indexOf(field)],
                                      ),
                                    ),
                                  } else if (field.inputType == FieldInputTypeEnum.TEXT) ...{
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: CustomTextInput(
                                        title: field.title,
                                        placeholder: field.defaultValue,
                                        controller: _textFieldsControllerList[textFields.indexOf(field)],
                                      ),
                                    ),
                                  }
                                },
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Divider(
                        color: CustomColors.grey200,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'امکانات',
                          style: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset('assets/images/icon-pen.png'),
                        ),
                      ],
                    ),
                    for (var field in checkboxFields) ...{
                      CustomCheckbox(
                        title: field.title,
                        controller: _checkboxControllerList[checkboxFields.indexOf(field)],
                      ),
                    },
                  ],
                ),
              ),
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 42)),
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
                  if (_propertiesFormKey.currentState!.validate()) {
                    saveFields();
                    context.read<NavigationBloc>().add(navigateToNextPageEvent());
                  } else {
                    _showSnackBar(context);
                  }
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

  Flushbar<dynamic> _showSnackBar(BuildContext context) {
    return Flushbar(
      backgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      borderRadius: BorderRadius.circular(5),
      duration: Duration(seconds: 2),
      messageText: Text('لطفا تمامی فیلد ها را پر کنید !', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'sb', fontSize: 12, color: Colors.white)),
      icon: Icon(Icons.info_outline, size: 28.0, color: Colors.white),
      shouldIconPulse: false,
    )..show(context);
  }
}
