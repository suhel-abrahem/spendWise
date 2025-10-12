// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryEntityImpl _$$CategoryEntityImplFromJson(Map<String, dynamic> json) =>
    _$CategoryEntityImpl(
      id: json['id'] as String? ?? "",
      name:
          (json['name'] as List<dynamic>?)?.map((e) => e as String?).toList() ??
          const ["", "", ""],
      defaultLanguage: (json['defaultLanguage'] as num?)?.toInt() ?? 0,
      icon:
          json['icon'] == null
              ? null
              : const IconDataJsonConverter().fromJson(
                json['icon'] as Map<String, dynamic>?,
              ),
    );

Map<String, dynamic> _$$CategoryEntityImplToJson(
  _$CategoryEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'defaultLanguage': instance.defaultLanguage,
  'icon': const IconDataJsonConverter().toJson(instance.icon),
};
