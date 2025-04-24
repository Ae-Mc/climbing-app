import 'package:climbing_app/features/rating/domain/entities/ascent_read.dart';
import 'package:climbing_app/features/rating/domain/repositories/rating_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_rating.g.dart';

@riverpod
Future<List<AscentRead>> userRating(UserRatingRef ref, String userId) =>
    GetIt.I<RatingRepository>().getUserRatingAscents(userId);
