part of 'rating_bloc.dart';

@freezed
class RatingEvent with _$RatingEvent {
  const factory RatingEvent.refresh() = _Refresh;
  const factory RatingEvent.setMustBeFemale(bool mustBeFemale) =
      _SetMustBeFemale;
  const factory RatingEvent.setMustBeStudent(bool mustBeStudent) =
      _SetMustBeStudent;
}
