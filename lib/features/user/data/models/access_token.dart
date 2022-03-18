import 'package:freezed_annotation/freezed_annotation.dart';

part 'access_token.freezed.dart';
part 'access_token.g.dart';

@freezed
class AccessToken with _$AccessToken {
  factory AccessToken({
    required String accessToken,
    required String tokenType,
  }) = _;

  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);
}
