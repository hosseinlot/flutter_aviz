import 'package:aviz_app/bloc/naviagtion/navigation_bloc.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_event.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/data/model/sub_category.dart';
import 'package:aviz_app/screens/add_aviz/aviz_data_temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoryItems extends StatefulWidget {
  SubCategoryItems({super.key});

  @override
  State<SubCategoryItems> createState() => _SubCategoryItemsState();
}

class _SubCategoryItemsState extends State<SubCategoryItems> {
  final List<SubCategory> subCategoryList = AvizDataTemp.selectedCategory!.subCategories;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(padding: EdgeInsets.only(top: 20)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return GestureDetector(
                onTap: () {
                  AvizDataTemp.selectedSubCategory = subCategoryList[index];
                  context.read<NavigationBloc>().add(navigateToNextPageEvent());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/icon-arrow-left.png',
                          color: CustomColors.red,
                        ),
                        Spacer(),
                        Text(
                          subCategoryList[index].title!,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'sm',
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(width: 1, color: CustomColors.grey200),
                    ),
                  ),
                ),
              );
            },
            childCount: subCategoryList.length,
          ),
        ),
      ],
    );
  }
}
