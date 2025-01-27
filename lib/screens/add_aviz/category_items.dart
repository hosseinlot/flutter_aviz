import 'package:aviz_app/bloc/category/category_bloc.dart';
import 'package:aviz_app/bloc/category/category_event.dart';
import 'package:aviz_app/bloc/category/category_state.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_bloc.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_event.dart';
import 'package:aviz_app/screens/add_aviz/aviz_data_temp.dart';
import 'package:aviz_app/widgets/custom_widgets/custom_category_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItems extends StatefulWidget {
  CategoryItems({super.key});

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestEvent());
    AvizDataTemp.reset();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(padding: EdgeInsets.only(top: 20)),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryResponseState) {
              return state.response.fold(
                (l) {
                  return SliverToBoxAdapter(
                    child: Text('error'),
                  );
                },
                (categoryList) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            AvizDataTemp.selectedCategory = categoryList[index];
                            context.read<NavigationBloc>().add(navigateToNextPageEvent());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                            child: CustomCategoryButton(
                              title: categoryList[index].title!,
                              icon: categoryList[index].icon,
                            ),
                          ),
                        );
                      },
                      childCount: categoryList.length,
                    ),
                  );
                },
              );
            } else {
              return SliverToBoxAdapter(
                child: Text(''),
              );
            }
          },
        ),
      ],
    );
  }
}
