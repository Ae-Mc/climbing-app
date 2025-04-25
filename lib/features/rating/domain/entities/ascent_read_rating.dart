import 'package:climbing_app/features/rating/domain/entities/ascent_read.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ascent_read_rating.freezed.dart';
part 'ascent_read_rating.g.dart';

@freezed
sealed class AscentReadRating with _$AscentReadRating implements AscentRead {
  const factory AscentReadRating({
    required String id,
    required bool isFlash,
    required bool takenInAccount,
    required DateTime date,
    required Route route,
  }) = _;

  factory AscentReadRating.fromJson(Map<String, dynamic> json) =>
      _$AscentReadRatingFromJson(json);
}
