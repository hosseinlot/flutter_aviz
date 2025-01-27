import 'package:aviz_app/bloc/aviz_detail/aviz_author_status.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_bookmark_status.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_event.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_state.dart';
import 'package:aviz_app/bloc/aviz_detail/aviz_detail_status.dart';
import 'package:aviz_app/constants/data_state.dart';
import 'package:aviz_app/data/repository/aviz_detail_repository.dart';
import 'package:bloc/bloc.dart';

import '../../di.dart';

class AvizDetailBloc extends Bloc<AvizDetailEvent, AvizDetailState> {
  final IAvizDetailRepository _avizDetailRepository = locator.get();

  AvizDetailBloc() : super(AvizDetailState(detailStatus: AvizDetailLoading(), authorStatus: AvizAthorInitial(), bookmarkStatus: AvizBookmarkInitial())) {
    on<AvizGetDetailEvent>(
      (event, emit) async {
        emit(state.copyWith(newDetailStatus: AvizDetailLoading()));
        var avizDetail = await _avizDetailRepository.getAvizDetail(event.avizId);
        var variantDetail = await _avizDetailRepository.getAvizVariants(event.avizId);

        if (avizDetail is DataSuccess && variantDetail is DataSuccess) {
          emit(state.copyWith(newDetailStatus: AvizDetailSuccess(avizDetail.data!, variantDetail.data!)));
        }
        if (avizDetail is DataFailed) {
          emit(state.copyWith(newDetailStatus: AvizDetailFailed('آویز مورد نظر یافت نشد ')));
        }
      },
    );

    on<AvizGetAuthorDetailEvent>(
      (event, emit) async {
        emit(state.copyWith(newAuthorStatus: AvizAthorLoading()));

        var authorDetail = await _avizDetailRepository.getAvizAuthorInfo(event.avizId);

        if (authorDetail is DataSuccess) {
          emit(state.copyWith(newAuthorStatus: AvizAthorSuccess(authorDetail.data!)));
        }
        if (authorDetail is DataFailed) {
          emit(state.copyWith(newAuthorStatus: AvizAthorFailed(authorDetail.error!)));
        }
      },
    );

    on<AvizGetBookmarkDetailEvent>(
      (event, emit) async {
        var bookmarkDetail = await _avizDetailRepository.isBookmarked(event.avizId);

        if (bookmarkDetail is DataSuccess) {
          emit(state.copyWith(newBookmarkStatus: AvizBookmarkSuccess(bookmarkDetail.data!)));
        }
        if (bookmarkDetail is DataFailed) {
          emit(state.copyWith(newBookmarkStatus: AvizBookmarkFailed(bookmarkDetail.error!)));
        }
      },
    );
  }
}
