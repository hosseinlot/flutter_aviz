import 'package:aviz_app/bloc/home/home_bloc.dart';
import 'package:aviz_app/bloc/home/home_event.dart';
import 'package:aviz_app/bloc/home/home_state.dart';
import 'package:aviz_app/bloc/user/user_bloc.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/data/model/aviz.dart';
import 'package:aviz_app/screens/aviz_detail_screen.dart';
import 'package:aviz_app/screens/normal_aviz_list_screen.dart';
import 'package:aviz_app/utils/settings_manager.dart';
import 'package:aviz_app/widgets/hot_aviz_card.dart';
import 'package:aviz_app/widgets/normal_aviz_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.isActive});
  final bool isActive;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Aviz> hotAvizList = [];
  List<Aviz> normalAvizList = [];
  String hotAvizError = '';
  String normalAvizError = '';
  String nextPageError = '';
  bool isLoadingNextPage = false;
  final _normalAvizscrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _normalAvizscrollController.addListener(
      () {
        if (_normalAvizscrollController.position.pixels == _normalAvizscrollController.position.maxScrollExtent && isLoadingNextPage == false) {
          isLoadingNextPage = true;
          context.read<HomeBloc>().add(HomeGetNextPageEvent());
        }
      },
    );
  }

  Future<void> _refresh() async {
    hotAvizList.clear();
    normalAvizList.clear();
    context.read<HomeBloc>().add(HomeGetInitializeDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final showHotAviz = SettingsManager.loadSettings()['showHotAviz'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'آویز',
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
          if (state is HomeRequestSuccess) {
            hotAvizList.addAll(state.hotAvizList);
            normalAvizList.addAll(state.normalAvizList);
            // hotAvizError = l;
          }
          if (state is HomeNextPageFailed) {
            isLoadingNextPage = false;
            nextPageError = 'مشکلی پیش آمده، لطفا دوباره تلاش نمایید';
          }
          if (state is HomeNextPageSuccess) {
            isLoadingNextPage = false;
            normalAvizList.addAll(state.normalAvizList);
            nextPageError = '';
          }
        },
        child: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
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
                    if (showHotAviz)
                      //
                      HotAvizTitle(),
                    if (showHotAviz)
                      //
                      _getHotAviz(hotAvizList),
                    NormalAvizTitle(),
                    _getNormalAviz(normalAvizList),
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

  _getNormalAviz(List<Aviz> normalAvizList) {
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

  SliverToBoxAdapter _getHotAviz(List<Aviz> hotAvizList) {
    if (hotAvizError.isNotEmpty) {
      return SliverToBoxAdapter(
        child: Center(child: Text('${hotAvizError}')),
      );
    }
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 310,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: hotAvizList.length,
          reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 20),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => UserBloc(),
                          ),
                        ],
                        child: AvizDetailScreen(avizId: hotAvizList[index].id),
                      ),
                    ));
                  },
                  child: HotAvizCard(aviz: hotAvizList[index])),
            );
          },
        ),
      ),
    );
  }
}

class NormalAvizTitle extends StatelessWidget {
  const NormalAvizTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (Newcontext) => BlocProvider(
                    create: (context) {
                      var bloc = HomeBloc();
                      bloc.add(HomeGetInitializeDataEvent());
                      return bloc;
                    },
                    child: NormalAvizListScreen(),
                  ),
                ),
              ),
              child: Text(
                'مشاهده همه',
                style: TextStyle(
                  fontFamily: 'sm',
                  fontSize: 14,
                  color: CustomColors.grey500,
                ),
              ),
            ),
            Text(
              'آویزهای اخیر',
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

class HotAvizTitle extends StatelessWidget {
  const HotAvizTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Text(
                'مشاهده همه',
                style: TextStyle(
                  fontFamily: 'sm',
                  fontSize: 14,
                  color: CustomColors.grey500,
                ),
              ),
            ),
            Text(
              'آویزهای داغ',
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
