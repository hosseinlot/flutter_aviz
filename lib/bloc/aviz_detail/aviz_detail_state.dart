import 'package:aviz_app/bloc/aviz_detail/aviz_author_status.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_bookmark_status.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_status.dart';

class AvizDetailState {
  final AvizDetailStatus detailStatus;
  final AvizAuthorStatus authorStatus;
  final AvizBookmarkStatus bookmarkStatus;

  const AvizDetailState({required this.detailStatus, required this.authorStatus, required this.bookmarkStatus});

  AvizDetailState copyWith({
    AvizDetailStatus? newDetailStatus,
    AvizAuthorStatus? newAuthorStatus,
    AvizBookmarkStatus? newBookmarkStatus,
  }) {
    return AvizDetailState(
      detailStatus: newDetailStatus ?? detailStatus,
      authorStatus: newAuthorStatus ?? authorStatus,
      bookmarkStatus: newBookmarkStatus ?? bookmarkStatus,
    );
  }
}
