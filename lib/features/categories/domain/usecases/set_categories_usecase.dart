import 'package:spend_wise/core/data_state/data_state.dart';
import 'package:spend_wise/core/usecase/usecase.dart';
import 'package:spend_wise/features/categories/domain/entities/category_entity.dart';

import '../repositories/categories_repository.dart';

class SetCategoriesUsecase
    implements UseCase<DataState<void>?, CategoryEntity?> {
  final CategoriesRepository _repository;
  SetCategoriesUsecase(this._repository);
  @override
  Future<DataState<void>?> call({CategoryEntity? params}) {
    return _repository.addCategory(params);
  }
}
