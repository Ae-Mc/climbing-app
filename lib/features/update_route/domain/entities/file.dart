import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'file.freezed.dart';

@freezed
sealed class File with _$File {
  const factory File({
    required String filename,
    required String contentType,
    required Uint8List data,
  }) = _File;
}
