import 'package:aviz_app/bloc/user/user_bloc.dart';
import 'package:aviz_app/bloc/user/user_event.dart';
import 'package:aviz_app/bloc/user/user_state.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/screens/aviz_detail_screen.dart';
import 'package:aviz_app/widgets/normal_aviz_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBookmarkScreen extends StatefulWidget {
  const MyBookmarkScreen({super.key});

  @override
  State<MyBookmarkScreen> createState() => _MyBookmarkScreenState();
}

class _MyBookmarkScreenState extends State<MyBookmarkScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserGetBookmarkListEvent());
  }

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
              'نشان های من',
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
        child: BlocBuilder<UserBloc, UserState>(
          buildWhen: (previous, current) {
            if (current is UserBookmarkListLoadSuccess || current is UserBookmarkListLoading) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state is UserBookmarkListLoading) {
              return Center(
                child: CircularProgressIndicator(color: CustomColors.red),
              );
            }
            if (state is UserBookmarkListLoadSuccess) {
              if (state.bookmarkList.isEmpty) {
                return Center(
                  child: Text(
                    'در حال حاضر هیچ آویز نشان شده ای برای شما وجود ندارد',
                    style: TextStyle(fontFamily: 'sm', fontSize: 14, color: Colors.black),
                  ),
                );
              }
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (cNontext, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (Newcontext) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: context.read<UserBloc>(),
                                      ),
                                    ],
                                    child: AvizDetailScreen(avizId: state.bookmarkList[index].id),
                                  ),
                                ));
                              },
                              child: NormalAvizCard(aviz: state.bookmarkList[index])),
                        );
                      },
                      childCount: state.bookmarkList.length,
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('errro getting list'),
              );
            }
          },
        ),
      ),
    );
  }
}
