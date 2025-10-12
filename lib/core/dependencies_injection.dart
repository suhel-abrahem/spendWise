import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/config/app/app_preferences.dart';
import 'package:spend_wise/features/categories/data/repositories/categories_repository_implements.dart';
import 'package:spend_wise/features/categories/domain/repositories/categories_repository.dart';
import 'package:spend_wise/features/categories/domain/usecases/delete_categories_usecase.dart';
import 'package:spend_wise/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:spend_wise/features/categories/domain/usecases/set_categories_usecase.dart';
import 'package:spend_wise/features/categories/presentation/bloc/category_bloc.dart';

GetIt getItInstance = GetIt.instance;
Future<void> initDependencies() async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  getItInstance.registerFactory<AppPreferences>(
    () => AppPreferences(_sharedPreferences),
  );
  getItInstance.registerSingleton<CategoriesRepository>(
    CategoriesRepositoryImplements(),
  );
  getItInstance.registerSingleton<SetCategoriesUsecase>(
    SetCategoriesUsecase(getItInstance()),
  );
  getItInstance.registerSingleton<GetCategoriesUsecase>(
    GetCategoriesUsecase(getItInstance()),
  );
  getItInstance.registerSingleton<DeleteCategoriesUsecase>(
    DeleteCategoriesUsecase(getItInstance()),
  );
  getItInstance.registerFactory<CategoryBloc>(
    () => CategoryBloc(getItInstance(), getItInstance(), getItInstance()),
  );
}
