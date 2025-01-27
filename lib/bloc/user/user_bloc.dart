import 'package:aviz_app/bloc/user/user_event.dart';
import 'package:aviz_app/bloc/user/user_state.dart';
import 'package:aviz_app/constants/data_state.dart';
import 'package:aviz_app/data/model/aviz.dart';
import 'package:aviz_app/data/repository/aviz_repository.dart';
import 'package:aviz_app/data/repository/profile_repository.dart';
import 'package:bloc/bloc.dart';

import '../../di.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IProfileRepository _profileRepository = locator.get();
  final IAvizRepository _avizRepository = locator.get();

  List<Aviz> bookmarkList = [];

  UserBloc() : super(UserInitState()) {
    on<UserGetInfoEvent>(
      (event, emit) async {
        emit(UserInfoLoading());

        var response = await _profileRepository.getUserInfo();

        if (response is DataSuccess) {
          emit(UserInfoLoadSuccess(response.data!));
        }

        if (response is DataFailed) {
          emit(UserInfoLoadFailed(response.error!));
        }
      },
    );

    on<UserGetAvizListEvent>(
      (event, emit) async {
        emit(UserAvizListLoading());

        var response = await _profileRepository.getUserAviz();

        if (response is DataSuccess) {
          emit(UserAvizListLoadSuccess(response.data!));
        }

        if (response is DataFailed) {
          emit(UserAvizListLoadFailed(response.error!));
        }
      },
    );

    on<UserGetBookmarkListEvent>(
      (event, emit) async {
        emit(UserBookmarkListLoading());
        var response = await _profileRepository.getUserBookmarks();

        if (response is DataSuccess) {
          bookmarkList = response.data!;
          emit(UserBookmarkListLoadSuccess(bookmarkList));
        }

        if (response is DataFailed) {
          emit(UserBookmarkListLoadFailed(response.error!));
        }
      },
    );

    on<BookmarkToggleEvent>(
      (event, emit) async {
        await _avizRepository.toggleBookmark(event.avizId);
        if (bookmarkList.isNotEmpty) {
          bookmarkList.removeWhere((element) => element.id == event.avizId);
          emit(UserBookmarkListLoadSuccess(bookmarkList));
        }
      },
    );
  }
}
