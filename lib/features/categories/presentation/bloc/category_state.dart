part of 'category_bloc.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = Initial;
  const factory CategoryState.loading() = Loading;
  const factory CategoryState.loaded(List<CategoryEntity?>? categories) =
      _Loaded;
  const factory CategoryState.error(String message) = Error;
  const factory CategoryState.added() = Added;
  const factory CategoryState.deleted() = Deleted;
  const factory CategoryState.empty() = Empty;
}
