import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_wise/features/categories/domain/entities/icon_json_converter.dart';
part 'category_entity.freezed.dart';
part 'category_entity.g.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    @Default("") String? id,
    @Default(["","",""]) List<String?> name,
    @Default(0) int?defaultLanguage,
    @IconDataJsonConverter() @Default(null) IconData? icon,
  }) = _CategoryEntity;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);
}
