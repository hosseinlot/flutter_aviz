import 'package:aviz_app/bloc/aviz_detail/aviz_author_status.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_bloc.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_event.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_state.dart';
import 'package:aviz_app/bloc/user/user_bloc.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/widgets/author_detail_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDoubleButtons extends StatelessWidget {
  CustomDoubleButtons({super.key, required this.avizId});

  final String avizId;

  @override
  Widget build(BuildContext context) {
    String filledPhoneNumber = '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 160,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.red,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              onPressed: () {
                if (filledPhoneNumber.isEmpty) {
                  context.read<AvizDetailBloc>().add(AvizGetAuthorDetailEvent(avizId));
                } else {
                  _getAuthorModal(context, filledPhoneNumber);
                }
              },
              child: BlocConsumer<AvizDetailBloc, AvizDetailState>(
                listenWhen: (previous, current) {
                  if (previous.authorStatus == current.authorStatus) {
                    return false;
                  } else {
                    return true;
                  }
                },
                listener: (context, state) {
                  if (state.authorStatus is AvizAthorSuccess) {
                    final AvizAthorSuccess avizAthorSuccess = state.authorStatus as AvizAthorSuccess;
                    String phoneNumber = avizAthorSuccess.phoneNumber;
                    filledPhoneNumber = phoneNumber;
                    _getAuthorModal(context, filledPhoneNumber);
                  }
                },
                builder: (context, state) {
                  if (state.authorStatus is AvizAthorLoading) {
                    return SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white));
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'اطلاعات تماس',
                          style: TextStyle(fontFamily: 'sm', fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-call.png')),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          Container(
            width: 160,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.red,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'گفتگو',
                    style: TextStyle(fontFamily: 'sm', fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  SizedBox(width: 24, height: 24, child: Image.asset('assets/images/icon-message.png')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _getAuthorModal(BuildContext context, String filledPhoneNumber) {
    return showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.35,
      backgroundColor: Colors.white,
      isDismissible: true,
      showDragHandle: true,
      elevation: 0,
      context: context,
      builder: (context2) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<UserBloc>(),
            ),
            BlocProvider.value(
              value: context.read<AvizDetailBloc>(),
            ),
          ],
          child: AuthorDetailModal(phoneNumber: filledPhoneNumber),
        );
      },
    );
  }
}
