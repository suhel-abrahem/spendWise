import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_wise/core/data_state/data_state.dart';
import 'package:spend_wise/core/usecase/usecase.dart';
import 'package:spend_wise/features/categories/domain/entities/category_entity.dart';

import '../../domain/usecases/delete_categories_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/set_categories_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';
part 'category_bloc.freezed.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final SetCategoriesUsecase _addCategoriesUsecase;
  final GetCategoriesUsecase _getCategoriesUsecase;
  final DeleteCategoriesUsecase _deleteCategoriesUsecase;
  CategoryBloc(
    this._addCategoriesUsecase,
    this._getCategoriesUsecase,
    this._deleteCategoriesUsecase,
  ) : super(Initial()) {
    on<_Started>((event, emit) async {});
    on<_AddCategory>((event, emit) async {
      emit(const CategoryState.loading());
      final result = await _addCategoriesUsecase.call(params: event.category);
      if (result != null) {
        if (result is DataSuccess) {
          emit(const CategoryState.added());
        } else if (result is DataError) {
          emit(CategoryState.error(result.error.toString()));
        }
      } else {
        emit(const CategoryState.error("Something went wrong"));
      }
    });
    on<_GetCategories>((event, emit) async {
      emit(const CategoryState.loading());
      final result = await _getCategoriesUsecase.call(params: event.category);
      print("result: ${result?.data}");
      if (result != null) {
        if (result is DataSuccess) {
          if (result.data == null || (result.data?.isEmpty ?? true)) {
            emit(const CategoryState.empty());
          } else {
            emit(CategoryState.loaded(result.data));
          }
        } else {
          emit(CategoryState.error("ezrror"));
        }
      } else {
        emit(const CategoryState.error("Something went wrong"));
      }
    });
    on<_DeleteCategory>((event, emit) async {
      emit(const CategoryState.loading());
      final result = await _deleteCategoriesUsecase.call(
        params: event.category,
      );
      if (result != null) {
        if (result is DataSuccess) {
          emit(const CategoryState.deleted());
        } else if (result is DataError) {
          emit(CategoryState.error(result.error.toString()));
        }
      } else {
        emit(const CategoryState.error("Something went wrong"));
      }
    });
  }
}
