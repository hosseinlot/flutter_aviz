import 'package:aviz_app/bloc/authentication/auth_bloc.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_bookmark_status.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_bloc.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_event.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_state.dart';
import 'package:aviz_app/bloc/user/user_bloc.dart';
import 'package:aviz_app/bloc/user/user_event.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/screens/authentication/login_screen.dart';
import 'package:aviz_app/utils/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthorDetailModal extends StatefulWidget {
  const AuthorDetailModal({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  State<AuthorDetailModal> createState() => _AuthorDetailModalState();
}

class _AuthorDetailModalState extends State<AuthorDetailModal> {
  // Send SMS
  Future<void> _launchSmsApp(String phoneNumber) async {
    final url = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not launch SMS app')));
    }
  }

// Call Contact
  Future<void> _launchDialer(String phoneNumber) async {
    final url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not launch phone dialer')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'اطلاعات تماس',
            style: TextStyle(fontFamily: 'dana', fontSize: 16, color: CustomColors.grey500),
          ),
          Divider(color: CustomColors.grey300),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _launchDialer(widget.phoneNumber);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'تماس تلفنی با ${widget.phoneNumber}',
                        style: TextStyle(fontFamily: 'dana', fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.call, color: CustomColors.red),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchSmsApp(widget.phoneNumber);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'ارسال پیامک به ${widget.phoneNumber}',
                        style: TextStyle(fontFamily: 'dana', fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.sms, color: CustomColors.red),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'شروع گفتگو',
                        style: TextStyle(fontFamily: 'dana', fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.chat, color: CustomColors.red),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (AuthManager.isLogedIn()) {
                      context.read<UserBloc>().add(BookmarkToggleEvent('743c917csxftwr4'));
                      context.read<AvizDetailBloc>().add(AvizGetBookmarkDetailEvent('743c917csxftwr4'));
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => AuthBloc(),
                                child: LoginScreen(shouldRedirect: true),
                              )));
                    }
                  },
                  // Bookmark Button
                  child: BlocBuilder<AvizDetailBloc, AvizDetailState>(
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
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [Text('حذف از لیست نشان ها', style: TextStyle(fontFamily: 'dana', fontSize: 16)), SizedBox(width: 8), Icon(Icons.bookmark_add, color: CustomColors.red)],
                              )
                            : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                Text('نشان کن تا بعدا تماس بگیرم', style: TextStyle(fontFamily: 'dana', fontSize: 16)),
                                SizedBox(width: 8),
                                Icon(Icons.bookmark_add, color: CustomColors.red)
                              ]);
                      } else {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Text('نشان کن تا بعدا تماس بگیرم', style: TextStyle(fontFamily: 'dana', fontSize: 16)), SizedBox(width: 8), Icon(Icons.bookmark_add, color: CustomColors.red)]);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
