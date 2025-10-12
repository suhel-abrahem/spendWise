import 'dart:convert';

import 'package:spend_wise/config/app/app_preferences.dart';
import 'package:spend_wise/core/constants/shared_preferences_keys.dart';
import 'package:spend_wise/core/data_state/data_state.dart';
import 'package:spend_wise/core/dependencies_injection.dart';
import 'package:spend_wise/features/categories/domain/entities/category_entity.dart';
import 'package:spend_wise/features/categories/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImplements implements CategoriesRepository {
  @override
  Future<DataState<void>?> addCategory(CategoryEntity? category) async {
    try {
      List<String?>? localyData = getItInstance<AppPreferences>().getDataLocale(
        key: SharedPreferencesKeys.categoryKey,
      );
      final String id =
          getItInstance<AppPreferences>().getDataLocale(
            key: SharedPreferencesKeys.categoryIndexKey,
          )?[0] ??
          "0";

      localyData?.add(jsonEncode(category?.copyWith(id: id).toJson()));
      getItInstance<AppPreferences>().setDataLocale(
        data: localyData,
        key: SharedPreferencesKeys.categoryKey,
      );
      return DataSuccess(data: null);
    } catch (e) {
      return DataError(error: e.toString());
    }
  }

  @override
  Future<DataState<void>?> deleteCategory(
    List<CategoryEntity?>? category,
  ) async {
    try {
      List<String?>? localeData = getItInstance<AppPreferences>().getDataLocale(
        key: SharedPreferencesKeys.categoryKey,
      );
      category?.forEach((category) {
        localeData?.removeAt(
          localeData.indexWhere(
            (selectedCategory) =>
                selectedCategory == jsonEncode(category?.toJson()),
          ),
        );
      });
      await getItInstance<AppPreferences>().setDataLocale(
        data: localeData,
        key: SharedPreferencesKeys.categoryKey,
      );
      return DataSuccess();
    } catch (e) {
      return DataError(error: e.toString());
    }
  }

  @override
  Future<DataState<List<CategoryEntity?>?>?> getCategories(
    CategoryEntity? category,
  ) async {
    try {
      List<String?>? localyData = getItInstance<AppPreferences>().getDataLocale(
        key: SharedPreferencesKeys.categoryKey,
      );
      if (localyData == null || localyData.isEmpty) {
        return DataError(error: "Categories not found");
      }
      List<CategoryEntity?> categories = [];
      for (var element in localyData) {
        if (element != null && element.isNotEmpty) {
          categories.add(CategoryEntity.fromJson(jsonDecode(element)));
        }
      }
      return DataSuccess(data: categories);
    } catch (e) {
      return DataError(error: e.toString());
    }
  }
}
