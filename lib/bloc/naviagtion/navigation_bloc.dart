import 'package:aviz_app/bloc/naviagtion/navigation_event.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_state.dart';
import 'package:bloc/bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  double pageNumber = 0;

  NavigationBloc() : super(NavigationInCategoryState()) {
    on<NavigationToCategoryEvent>(
      (event, emit) {
        pageNumber = 0;
        emit(NavigationIndicatorUpdateState(pageNumber));
        emit(NavigationbarVisibilityState(true));
        emit(NavigationInCategoryState());
      },
    );

    on<navigateToNextPageEvent>(
      (event, emit) {
        if (pageNumber == 0) {
          pageNumber = 25;
          emit(NavigationIndicatorUpdateState(pageNumber));
          emit(NavigationInSubCategoryState());
        } else if (pageNumber == 25) {
          pageNumber = 50;
          emit(NavigationIndicatorUpdateState(pageNumber));
          emit(NavigationbarVisibilityState(false));
          emit(NavigationInPropertyCategoryState());
        } else if (pageNumber == 50) {
          pageNumber = 75;
          emit(NavigationIndicatorUpdateState(pageNumber));
          emit(NavigationbarVisibilityState(false));
          emit(NavigationInLocationSelectState());
        } else if (pageNumber == 75) {
          pageNumber = 100;
          emit(NavigationIndicatorUpdateState(pageNumber));
          emit(NavigationbarVisibilityState(false));
          emit(NavigationInFinilizeAdState());
        } else if (pageNumber == 100) {
          pageNumber = 0;
          emit(NavigationIndicatorUpdateState(pageNumber));
          emit(NavigationbarVisibilityState(true));
          emit(NavigationInCategoryState());
        }
      },
    );

    on<navigateToPreviousPageEvent>(
      (event, emit) {
        if (pageNumber == 0) {
          return;
        } else if (pageNumber == 25) {
          pageNumber = 0;
          emit(NavigationIndicatorUpdateState(pageNumber));
          emit(NavigationInCategoryState());
        } else if (pageNumber == 50) {
          pageNumber = 25;
          emit(NavigationIndicatorUpdateState(pageNumber));
          emit(NavigationbarVisibilityState(true));
          emit(NavigationInSubCategoryState());
        } else if (pageNumber == 75) {
          pageNumber = 50;
          emit(NavigationIndicatorUpdateState(pageNumber));
          emit(NavigationbarVisibilityState(false));
          emit(NavigationInPropertyCategoryState());
        } else if (pageNumber == 100) {
          pageNumber = 75;
          emit(NavigationIndicatorUpdateState(pageNumber));
          emit(NavigationbarVisibilityState(false));
          emit(NavigationInLocationSelectState());
        }
      },
    );
  }
}
