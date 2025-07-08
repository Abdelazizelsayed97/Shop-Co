import 'package:equatable/equatable.dart';

class DimensionsEntity extends Equatable {
  final double? height;
  final double? width;
  final double? depth;
  const DimensionsEntity({
    required this.height,
    required this.width,
    this.depth,
  });

  @override
  List<Object?> get props => [height, width, depth];
}
