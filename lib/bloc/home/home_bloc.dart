import 'package:aviz_app/bloc/home/home_event.dart';
import 'package:aviz_app/bloc/home/home_state.dart';
import 'package:aviz_app/constants/data_state.dart';
import 'package:aviz_app/data/repository/aviz_repository.dart';
import 'package:bloc/bloc.dart';

import '../../di.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IAvizRepository _avizRepository = locator.get();
  int pageNumber = 1;

  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInitializeDataEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        pageNumber = 1;

        var hotAvizList = await _avizRepository.getHotAviz();
        var normalAvizList = await _avizRepository.getNormalAviz(pageNumber);

        if (hotAvizList is DataSuccess && normalAvizList is DataSuccess) {
          emit(HomeRequestSuccess(hotAvizList.data!, normalAvizList.data!));
        }

        if (hotAvizList is DataFailed || normalAvizList is DataFailed) {
          emit(HomeRequestFailed(hotAvizList.error!));
        }
      },
    );

    on<HomeGetNextPageEvent>(
      (event, emit) async {
        emit(HomeNextPageLoadingState());
        pageNumber++;

        var normalAvizList = await _avizRepository.getNormalAviz(pageNumber);

        if (normalAvizList is DataSuccess) {
          pageNumber -= normalAvizList.data!.isEmpty ? 1 : 0;
          emit(HomeNextPageSuccess(normalAvizList.data!));
        }

        if (normalAvizList is DataFailed) {
          pageNumber--;
          emit(HomeNextPageFailed(normalAvizList.error!));
        }
      },
    );

    on<HomeGetAllAvizEvent>(
      (event, emit) async {
        emit(HomeAllAvizLoadingState());
        pageNumber = 1;

        var allAvizList = await _avizRepository.getAllAviz(pageNumber);

        if (allAvizList is DataSuccess) {
          emit(HomeAllAvizSuccess(allAvizList.data!));
        }

        if (allAvizList is DataFailed) {
          emit(HomeAllAvizFailed(allAvizList.error!));
        }
      },
    );
  }
}
