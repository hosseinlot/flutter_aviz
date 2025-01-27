import 'package:aviz_app/bloc/user/user_bloc.dart';
import 'package:aviz_app/bloc/user/user_event.dart';
import 'package:aviz_app/bloc/user/user_state.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/screens/aviz_detail_screen.dart';
import 'package:aviz_app/widgets/normal_aviz_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAvizScreen extends StatefulWidget {
  const MyAvizScreen({super.key});

  @override
  State<MyAvizScreen> createState() => _MyAvizScreenState();
}

class _MyAvizScreenState extends State<MyAvizScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserGetAvizListEvent());
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
              'آویز های من',
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
          builder: (context, state) {
            if (state is UserAvizListLoading) {
              return Center(
                child: CircularProgressIndicator(color: CustomColors.red),
              );
            }
            if (state is UserAvizListLoadSuccess) {
              var avizList = state.avizList;
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) => UserBloc(),
                                      ),
                                    ],
                                    child: AvizDetailScreen(avizId: avizList[index].id),
                                  ),
                                ));
                              },
                              child: NormalAvizCard(aviz: avizList[index])),
                        );
                      },
                      childCount: avizList.length,
                    ),
                  ),
                ],
              );
            } else if (state is UserAvizListLoadFailed) {
              var errorMessage = state.response;
              return Center(child: Text(errorMessage));
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
