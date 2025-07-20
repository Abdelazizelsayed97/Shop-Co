import 'package:equatable/equatable.dart';

class PaginatedData<T> extends Equatable {
  final List<T> data;
  final bool hasNext;
  final int? page;
  final int? limit;

  const PaginatedData({
    this.page,
    this.limit,
    required this.data,
    required this.hasNext,
  });

  @override
  List<Object?> get props => [data, hasNext, page, limit];
}
