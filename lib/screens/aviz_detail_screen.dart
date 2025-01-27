import 'package:aviz_app/bloc/authentication/auth_bloc.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_bookmark_status.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_bloc.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_event.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_state.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_status.dart';
import 'package:aviz_app/bloc/user/user_bloc.dart';
import 'package:aviz_app/bloc/user/user_event.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/data/model/aviz.dart';
import 'package:aviz_app/data/model/variant.dart';
import 'package:aviz_app/screens/authentication/login_screen.dart';
import 'package:aviz_app/screens/warning_screen.dart';
import 'package:aviz_app/utils/auth_manager.dart';
import 'package:aviz_app/utils/settings_manager.dart';
import 'package:aviz_app/utils/string_extensions.dart';
import 'package:aviz_app/widgets/cached_image.dart';
import 'package:aviz_app/widgets/custom_widgets/custom_category_button.dart';
import 'package:aviz_app/widgets/custom_widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/custom_widgets/custom_double_buttons.dart';

class AvizDetailScreen extends StatefulWidget {
  const AvizDetailScreen({super.key, required this.avizId});
  final String avizId;

  @override
  State<AvizDetailScreen> createState() => _AvizDetailScreenState();
}

class _AvizDetailScreenState extends State<AvizDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AvizDetailBloc(),
      child: AvizDetailContainer(avizId: widget.avizId),
    );
  }
}

class AvizDetailContainer extends StatefulWidget {
  AvizDetailContainer({
    super.key,
    required this.avizId,
  });

  final String avizId;

  @override
  State<AvizDetailContainer> createState() => _AvizDetailContainerState();
}

class _AvizDetailContainerState extends State<AvizDetailContainer> {
  @override
  void initState() {
    super.initState();
    context.read<AvizDetailBloc>().add(AvizGetDetailEvent(widget.avizId));
    context.read<AvizDetailBloc>().add(AvizGetBookmarkDetailEvent(widget.avizId));
  }

  var _textButtonSelectedIndex = 0;
  var textButtons = [
    'مشخصات',
    'قیمت',
    'ویژگی ها و امکانات',
    'توضیحات',
  ];

  @override
  Widget build(BuildContext context) {
    final showAvizAlert = SettingsManager.loadSettings()['showAvizAlert'];
    final showSeperateWidgets = SettingsManager.loadSettings()['showSeperateWidgets'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/images/icon-appbar-arrow-right.png'),
            ),
          )
        ],
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (AuthManager.isLogedIn()) {
                    context.read<UserBloc>().add(BookmarkToggleEvent(widget.avizId));
                    context.read<AvizDetailBloc>().add(AvizGetBookmarkDetailEvent(widget.avizId));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => AuthBloc(),
                              child: LoginScreen(shouldRedirect: true),
                            )));
                  }
                },
                icon: BlocBuilder<AvizDetailBloc, AvizDetailState>(
                  buildWhen: (previous, current) {
                    if (previous.bookmarkStatus == current.bookmarkStatus) {
                      return false;
                    } else {
                      return true;
                    }
                  },
                  builder: (context, state) {
                    if (state.bookmarkStatus is AvizBookmarkSuccess) {
                      final AvizBookmarkSuccess avizDetailSuccess = state.bookmarkStatus as AvizBookmarkSuccess;
                      bool isBookmarked = avizDetailSuccess.isBookmarked;
                      return isBookmarked
                          ? SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-bookmark-fill.png'))
                          : SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-bookmark.png'));
                    } else {
                      return SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-bookmark.png'));
                    }
                  },
                ),
              ),
              BlocBuilder<AvizDetailBloc, AvizDetailState>(
                builder: (context, state) {
                  Aviz? avizDetail;
                  if (state.detailStatus is AvizDetailSuccess) {
                    final AvizDetailSuccess avizDetailSuccess = state.detailStatus as AvizDetailSuccess;
                    avizDetail = avizDetailSuccess.aviz;
                  }
                  return IconButton(
                    onPressed: () async {
                      String url = 'https://avizApp/aviz/${widget.avizId}';
                      await Share.share('عنوان : ${avizDetail?.title} \n ${url} \n منتشر شده : ${avizDetail?.createTime.parseToNamedDateTime()}');
                    },
                    icon: SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-share.png')),
                  );
                },
              ),
              IconButton(
                onPressed: () {},
                icon: SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-information.png')),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<AvizDetailBloc, AvizDetailState>(
        buildWhen: (previous, current) {
          if (previous.detailStatus == current.detailStatus) {
            return false;
          } else {
            return true;
          }
        },
        builder: (context, state) {
          if (state.detailStatus is AvizDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.detailStatus is AvizDetailFailed) {
            final AvizDetailFailed avizDetailFailed = state.detailStatus as AvizDetailFailed;
            var errorMessage = avizDetailFailed.message;

            return Center(
              child: Text(errorMessage),
            );
          } else if (state.detailStatus is AvizDetailSuccess) {
            final AvizDetailSuccess avizDetailSuccess = state.detailStatus as AvizDetailSuccess;
            Aviz avizDetail = avizDetailSuccess.aviz;
            List<Variant> variantList = avizDetailSuccess.variantList;

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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 220,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: (avizDetail.thumbnail == null) ? Image.asset('assets/images/image-placholder.png') : CachedImage(imageUrl: avizDetail.thumbnail),
                                ),
                              ),
                            ),
                            SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  avizDetail.createTime.parseToNamedDateTime(),
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: 'sm',
                                    fontSize: 14,
                                    color: CustomColors.grey500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: CustomColors.grey100,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Text(
                                      '${avizDetail.category}',
                                      style: TextStyle(fontFamily: 'sb', fontSize: 12, color: CustomColors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Text(avizDetail.title, style: TextStyle(fontFamily: 'sb', fontSize: 16)),
                            SizedBox(height: 32),
                            CustomDivider(),
                            SizedBox(height: 32),
                            if (showAvizAlert)
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WarningScreen()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 32),
                                  child: CustomCategoryButton(title: 'هشدار های قبل از معامله!', color: CustomColors.grey400, icon: Icon(Icons.warning, color: Colors.black)),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child: (showSeperateWidgets) ? _showSeperateWidgets(variantList) : _showAllWidgets(variantList)),
                      SliverPadding(padding: EdgeInsets.symmetric(vertical: 42)),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    child: CustomDoubleButtons(avizId: widget.avizId),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Column _showSeperateWidgets(List<Variant> variantList) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 28,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            reverse: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _textButtonSelectedIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (_textButtonSelectedIndex == index) ? CustomColors.red : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      textButtons[index],
                      style: TextStyle(
                        fontFamily: 'sm',
                        fontSize: 14,
                        color: (_textButtonSelectedIndex == index) ? Colors.white : CustomColors.red,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: textButtons.length,
          ),
        ),
        SizedBox(height: 32),
        Visibility(
          visible: (_textButtonSelectedIndex == 0),
          child: DetailContainer(detailVariants: variantList.where((element) => element.type == 'مشخصات').toList()),
        ),
        SizedBox(height: 20),
        Visibility(
          visible: (_textButtonSelectedIndex == 0),
          child: LocationContainer(),
        ),
        Visibility(
          visible: (_textButtonSelectedIndex == 1),
          child: PriceContainer(priceVariants: variantList.where((element) => element.type == 'قیمت').toList()),
        ),
        Visibility(
          visible: (_textButtonSelectedIndex == 2),
          child: FeautersContainer(
            featureVariants: variantList.where((element) => element.type == 'ویژگی').toList(),
          ),
        ),
        Visibility(
          visible: (_textButtonSelectedIndex == 2),
          child: AccessibilityContainer(
            accessibilityVariants: variantList.where((element) => element.type == 'امکانات').toList(),
          ),
        ),
        Visibility(
          visible: (_textButtonSelectedIndex == 3),
          child: DescriptionContainer(
            descriptionVariants: variantList.where((element) => element.type == 'توضیحات').toList(),
          ),
        ),
      ],
    );
  }

  Column _showAllWidgets(List<Variant> variantList) {
    return Column(
      children: [
        DetailContainer(detailVariants: variantList.where((element) => element.type == 'مشخصات').toList()),
        SizedBox(height: 20),
        PriceContainer(priceVariants: variantList.where((element) => element.type == 'قیمت').toList()),
        SizedBox(height: 30),
        DescriptionContainer(descriptionVariants: variantList.where((element) => element.type == 'توضیحات').toList()),
        SizedBox(height: 30),
        FeautersContainer(featureVariants: variantList.where((element) => element.type == 'ویژگی').toList()),
        AccessibilityContainer(accessibilityVariants: variantList.where((element) => element.type == 'امکانات').toList()),
        SizedBox(height: 30),
        LocationContainer(),
      ],
    );
  }
}

class LocationContainer extends StatelessWidget {
  const LocationContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        SizedBox(height: 24),
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
      ],
    );
  }
}

class DescriptionContainer extends StatelessWidget {
  const DescriptionContainer({
    super.key,
    required this.descriptionVariants,
  });
  final List<Variant> descriptionVariants;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        descriptionVariants.length,
        (index) {
          return Text(
            descriptionVariants.first.value!,
            style: TextStyle(
              fontFamily: 'sm',
              fontSize: 14,
              color: CustomColors.grey500,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.justify,
          );
        },
      ),
    );
  }
}

class FeautersContainer extends StatelessWidget {
  const FeautersContainer({
    super.key,
    required this.featureVariants,
  });
  final List<Variant> featureVariants;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: CustomColors.grey200),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                featureVariants.length,
                (index) {
                  return Column(
                    children: [
                      if (index != 0) CustomDivider(),
                      SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              featureVariants[index].value!,
                              style: TextStyle(fontFamily: 'sm', fontSize: 16, color: CustomColors.grey500),
                            ),
                            Text(
                              featureVariants[index].title!,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontFamily: 'sm', fontSize: 16, color: CustomColors.grey500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AccessibilityContainer extends StatelessWidget {
  const AccessibilityContainer({
    super.key,
    required this.accessibilityVariants,
  });

  final List<Variant> accessibilityVariants;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Row(
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
        ),
        SizedBox(height: 32),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: CustomColors.grey200),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                accessibilityVariants.length,
                (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          accessibilityVariants[index].title!,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontFamily: 'sm', fontSize: 16, color: CustomColors.grey500),
                        ),
                      ),
                      CustomDivider(),
                      if (index == accessibilityVariants.length - 1) ...{
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'برای اطلاعات بیشتر تماس بگیرید',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'sm', fontSize: 16, color: CustomColors.grey500),
                            ),
                          ),
                        )
                      },
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceContainer extends StatelessWidget {
  PriceContainer({
    super.key,
    required this.priceVariants,
  });

  final List<Variant> priceVariants;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: CustomColors.grey200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: List.generate(
            priceVariants.length,
            (index) => _buildPriceRow(priceVariants[index], index),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(Variant variant, int index) {
    int variantValue = variant.value;
    return Column(
      children: [
        if (index != 0) CustomDivider(),
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'تومان ${variantValue.parseToPrice()}',
                style: TextStyle(fontFamily: 'sm', fontSize: 16),
              ),
              Text(
                '${variant.title!} : ',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: 'sm', fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailContainer extends StatelessWidget {
  DetailContainer({
    super.key,
    required this.detailVariants,
  });

  final List<Variant> detailVariants;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: CustomColors.grey200),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: List.generate(
                detailVariants.length,
                (index) => _buildDetailItem(detailVariants[index], index),
              ),
            ),
          ),
        ),
        // SizedBox(height: 20),
        // Column(
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //         Text(
        //           'موقعیت مکانی',
        //           style: TextStyle(
        //             fontFamily: 'sb',
        //             fontSize: 16,
        //           ),
        //         ),
        //         SizedBox(width: 8),
        //         SizedBox(
        //           width: 24,
        //           height: 24,
        //           child: Image.asset('assets/images/icon-map.png'),
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 24),
        //     GestureDetector(
        //       onTap: () async {},
        //       child: Stack(
        //         alignment: AlignmentDirectional.center,
        //         children: [
        //           ClipRRect(
        //             borderRadius: BorderRadius.circular(10),
        //             child: SizedBox(
        //               width: double.infinity,
        //               height: 184,
        //               child: Image.asset(
        //                 'assets/images/background-map.png',
        //                 fit: BoxFit.cover,
        //               ),
        //             ),
        //           ),
        //           Container(
        //             width: 190,
        //             child: ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                   backgroundColor: CustomColors.red,
        //                   padding: EdgeInsets.only(left: 8, right: 16),
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(5),
        //                   )),
        //               onPressed: () {},
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-gps.png')),
        //                   SizedBox(width: 12),
        //                   Flexible(
        //                     child: Text(
        //                       'گرگان، صیاد شیرازی آبادانی',
        //                       overflow: TextOverflow.ellipsis,
        //                       maxLines: 1,
        //                       textDirection: TextDirection.rtl,
        //                       style: TextStyle(
        //                         fontFamily: 'sm',
        //                         fontSize: 16,
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildDetailItem(Variant variant, int index) {
    return Expanded(
      child: Row(
        children: [
          if (index != 0)
            SizedBox(
              width: 1,
              height: 100,
              child: CustomPaint(
                painter: CustomDividerVertical(CustomColors.grey300),
              ),
            ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      variant.title!,
                      style: TextStyle(fontFamily: 'sm', fontSize: 14, color: CustomColors.grey500),
                    ),
                    Text(
                      '${variant.value}',
                      style: TextStyle(fontFamily: 'sm', fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
