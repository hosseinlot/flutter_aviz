import 'package:aviz_app/bloc/category/category_event.dart';
import 'package:aviz_app/bloc/category/category_state.dart';
import 'package:aviz_app/data/repository/category_repository.dart';
import 'package:bloc/bloc.dart';

import '../../di.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _categoryRepository = locator.get();

  CategoryBloc() : super(CategoryInitState()) {
    on<CategoryRequestEvent>(
      (event, emit) async {
        emit(CategoryLoadingState());
        var response = await _categoryRepository.getCategories();
        emit(CategoryResponseState(response));
      },
    );
  }
}
