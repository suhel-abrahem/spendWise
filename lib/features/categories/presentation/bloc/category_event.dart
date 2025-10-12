part of 'category_bloc.dart';

@freezed
class CategoryEvent with _$CategoryEvent {
  const factory CategoryEvent.started() = _Started;
  const factory CategoryEvent.getCategories({CategoryEntity? category}) = _GetCategories;
  const factory CategoryEvent.addCategory(CategoryEntity category) =
      _AddCategory;
  const factory CategoryEvent.deleteCategory(List<CategoryEntity?>? category) =_DeleteCategory;
}