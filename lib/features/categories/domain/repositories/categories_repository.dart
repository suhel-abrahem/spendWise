import 'package:spend_wise/core/data_state/data_state.dart';
import 'package:spend_wise/features/categories/domain/entities/category_entity.dart';

abstract class CategoriesRepository {
  Future<DataState<List<CategoryEntity?>?>?> getCategories(
    CategoryEntity? category,
  );
  Future<DataState<void>?> addCategory(CategoryEntity? category);
  Future<DataState<void>?> deleteCategory(List<CategoryEntity?>? category);
}
