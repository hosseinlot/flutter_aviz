import 'package:aviz_app/bloc/search/search_bloc.dart';
import 'package:aviz_app/bloc/search/search_event.dart';
import 'package:aviz_app/bloc/search/search_state.dart';
import 'package:aviz_app/bloc/user/user_bloc.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/screens/aviz_detail_screen.dart';
import 'package:aviz_app/utils/debouncer.dart';
import 'package:aviz_app/widgets/normal_aviz_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.isActive});

  final bool isActive;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Debouncer debouncer = Debouncer(miliseconds: 500);

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchTextController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'آویز یاب',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'جستجو در آویز ها',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset('assets/images/icon-profile.png'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'از این قسمت هر چیزی که نیاز داری رو پیدا کن',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'sm',
                      fontSize: 14,
                      color: CustomColors.grey500,
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.symmetric(vertical: 10)),
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _searchTextController,
                  style: TextStyle(fontFamily: 'sm', fontSize: 16),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'دنبال چی میگردی ؟',
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: TextStyle(fontFamily: 'sb', fontSize: 16, color: Colors.grey[400]),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    debouncer.run(() {
                      if (value.isNotEmpty) {
                        context.read<SearchBloc>().add(SearchGetDataEvent(value));
                      }
                    });
                  },
                ),
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoadingState) {
                  return SliverToBoxAdapter(
                    child: Align(
                        child: Column(
                      children: [
                        SizedBox(height: 28),
                        CircularProgressIndicator(),
                      ],
                    )),
                  );
                } else if (state is SearchLoadSuccess) {
                  var normalAvizList = state.response;
                  if (!widget.isActive) {
                    normalAvizList.clear();
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
                            child: NormalAvizCard(aviz: normalAvizList[index]),
                          ),
                        );
                      },
                      childCount: normalAvizList.length,
                    ),
                  );
                } else if (state is SearchLoadFailed) {
                  return SliverToBoxAdapter(child: Align(child: Text('خطا در دریافت اطلاعات از سرور')));
                } else {
                  return SliverToBoxAdapter();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    debouncer.reset();
    super.dispose();
  }
}
