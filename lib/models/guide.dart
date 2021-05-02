import 'package:intl/intl.dart';

class Guide {
  final DateTime date;
  final List<Track> leftTracks;
  final List<Track> rightTracks;

  Guide({
    required this.date,
    required this.leftTracks,
    required this.rightTracks,
  });

  String get dateString => DateFormat.yQQQ().format(date);
}

class Track implements Comparable<Track> {
  final String name;
  final String author;
  final String? description;
  final String category;
  final String marksColor;
  final List<String> images;

  Track({
    required this.name,
    required this.author,
    required this.category,
    required this.marksColor,
    required this.images,
    this.description,
  });

  @override
  int compareTo(Track other) {
    final categoryComparisonResult = category.compareTo(other.category);
    if (categoryComparisonResult == 0) return name.compareTo(other.name);
    return categoryComparisonResult;
  }
}
