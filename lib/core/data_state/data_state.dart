abstract class DataState<T> {
  final T? data;
  final String? error;
  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({super.data});
}

class DataError<T> extends DataState<T> {
  const DataError({required String? error}) : super(error: error);
}
