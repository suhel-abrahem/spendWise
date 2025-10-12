import 'package:spend_wise/core/data_state/data_state.dart';
import 'package:spend_wise/core/usecase/usecase.dart';
import 'package:spend_wise/features/categories/domain/entities/category_entity.dart';

import '../repositories/categories_repository.dart';

class DeleteCategoriesUsecase
    implements UseCase<DataState<void>?, List<CategoryEntity?>?> {
  final CategoriesRepository _repository;
  DeleteCategoriesUsecase(this._repository);
  @override
  Future<DataState<void>?> call({List<CategoryEntity?>? params}) {
    return _repository.deleteCategory(params);
  }
}
