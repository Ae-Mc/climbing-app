part of 'rating_bloc.dart';

@freezed
sealed class RatingEvent with _$RatingEvent {
  const factory RatingEvent.refresh() = RatingEventRefresh;
  const factory RatingEvent.setMustBeFemale(bool mustBeFemale) =
      RatingEventSetMustBeFemale;
  const factory RatingEvent.setMustBeStudent(bool mustBeStudent) =
      RatingEventSetMustBeStudent;
}
