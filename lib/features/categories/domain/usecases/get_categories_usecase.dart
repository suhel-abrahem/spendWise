import 'package:spend_wise/core/data_state/data_state.dart';
import 'package:spend_wise/core/usecase/usecase.dart';

import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

class GetCategoriesUsecase
    implements UseCase<DataState<List<CategoryEntity?>?>?, CategoryEntity?> {
  final CategoriesRepository _repository;
  GetCategoriesUsecase(this._repository);
  @override
  Future<DataState<List<CategoryEntity?>?>?> call({CategoryEntity? params}) {
    return _repository.getCategories(params);
  }
}
