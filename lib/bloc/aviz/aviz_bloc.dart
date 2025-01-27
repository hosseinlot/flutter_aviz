import 'package:aviz_app/bloc/aviz/aviz_event.dart';
import 'package:aviz_app/bloc/aviz/aviz_state.dart';
import 'package:aviz_app/constants/data_state.dart';
import 'package:aviz_app/data/repository/aviz_repository.dart';
import 'package:bloc/bloc.dart';

import '../../di.dart';

class AvizBloc extends Bloc<AvizEvent, AvizState> {
  final IAvizRepository _avizRepository = locator.get();

  AvizBloc() : super(AvizInitState()) {
    on<AvizAddEvent>(
      (event, emit) async {
        emit(AvizAddLoading());
        var response = await _avizRepository.addAviz(event.title, event.category, event.subCategory, event.selectedThumbnail, event.fields);

        if (response is DataSuccess) {
          emit(AvizAddSuccess(response.data!));
        }

        if (response is DataFailed) {
          emit(AvizAddFailed(response.error!));
        }
      },
    );
  }
}
