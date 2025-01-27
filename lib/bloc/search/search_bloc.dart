import 'package:aviz_app/bloc/search/search_event.dart';
import 'package:aviz_app/bloc/search/search_state.dart';
import 'package:aviz_app/constants/data_state.dart';
import 'package:aviz_app/data/repository/aviz_repository.dart';
import 'package:bloc/bloc.dart';

import '../../di.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IAvizRepository _avizRepository = locator.get();

  SearchBloc() : super(SearchInitState()) {
    on<SearchGetDataEvent>(
      (event, emit) async {
        emit(SearchLoadingState());
        var avizList = await _avizRepository.searchAviz(event.enteredText);

        if (avizList is DataSuccess) {
          emit(SearchLoadSuccess(avizList.data!));
        }

        if (avizList is DataFailed) {
          emit(SearchLoadFailed(avizList.error!));
        }
      },
    );
  }
}
