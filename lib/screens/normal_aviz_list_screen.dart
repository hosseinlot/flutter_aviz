import 'package:aviz_app/bloc/home/home_bloc.dart';
import 'package:aviz_app/bloc/home/home_event.dart';
import 'package:aviz_app/bloc/home/home_state.dart';
import 'package:aviz_app/bloc/user/user_bloc.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/data/model/aviz.dart';
import 'package:aviz_app/screens/aviz_detail_screen.dart';
import 'package:aviz_app/widgets/normal_aviz_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NormalAvizListScreen extends StatefulWidget {
  const NormalAvizListScreen({super.key});

  @override
  State<NormalAvizListScreen> createState() => _NormalAvizListScreenState();
}

class _NormalAvizListScreenState extends State<NormalAvizListScreen> {
  List<Aviz> allAvizList = [];
  String normalAvizError = '';
  String nextPageError = '';
  bool isLoadingNextPage = false;
  final _normalAvizscrollController = ScrollController();

  Future<void> _refresh() async {
    allAvizList.clear();
    context.read<HomeBloc>().add(HomeGetAllAvizEvent());
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeGetAllAvizEvent());
    _normalAvizscrollController.addListener(
      () {
        if (_normalAvizscrollController.position.pixels == _normalAvizscrollController.position.maxScrollExtent && isLoadingNextPage == false) {
          isLoadingNextPage = true;
          context.read<HomeBloc>().add(HomeGetNextPageEvent());
        }
      },
    );
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
              'آویز ها',
              style: TextStyle(
                fontFamily: 'sb',
                fontSize: 20,
                color: CustomColors.red,
              ),
            ),
            SizedBox(width: 6),
            SizedBox(
              width: 28,
              height: 28,
              child: Image.asset(
                'assets/images/aviz-logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeAllAvizSuccess) {
            allAvizList.addAll(state.allAvizList);
          }
          if (state is HomeAllAvizFailed) {
            isLoadingNextPage = false;
            nextPageError = 'مشکلی پیش آمده، لطفا دوباره تلاش نمایید';
          }
          if (state is HomeNextPageSuccess) {
            isLoadingNextPage = false;
            allAvizList.addAll(state.normalAvizList);
            nextPageError = '';
          }
        },
        child: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeAllAvizLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return RefreshIndicator(
                onRefresh: _refresh,
                color: Colors.white,
                backgroundColor: Colors.black,
                child: CustomScrollView(
                  controller: _normalAvizscrollController,
                  slivers: [
                    AllAvizTitle(),
                    _getAllAviz(allAvizList),
                    if (nextPageError.isNotEmpty) ...{
                      SliverToBoxAdapter(
                        child: Align(
                          child: Text(
                            nextPageError,
                            style: TextStyle(
                              fontFamily: 'dana',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    },
                    SliverPadding(padding: EdgeInsets.only(bottom: 20)),
                    if (state is HomeNextPageLoadingState) ...{
                      SliverToBoxAdapter(
                        child: Align(
                          child: SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      SliverPadding(padding: EdgeInsets.only(bottom: 40)),
                    },
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _getAllAviz(List<Aviz> normalAvizList) {
    if (normalAvizError.isNotEmpty) {
      return SliverToBoxAdapter(
        child: Center(child: Text('${normalAvizError}')),
      );
    }
    return SliverList(
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
                      child: AvizDetailScreen(avizId: normalAvizList[index].id),
                    ),
                  ));
                },
                child: NormalAvizCard(aviz: normalAvizList[index])),
          );
        },
        childCount: normalAvizList.length,
      ),
    );
  }
}

class AllAvizTitle extends StatelessWidget {
  const AllAvizTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'همه آویزها',
              style: TextStyle(
                fontFamily: 'sb',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
