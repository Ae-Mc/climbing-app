import 'package:traverse/models/lap.dart';
import 'package:traverse/utils/database_helper.dart';

class Record {
  int id;
  Lap firstLap;
  Lap secondLap;
  Lap thirdLap;
  DateTime dateTime;

  Record({
    this.dateTime,
    this.firstLap,
    this.secondLap,
    this.thirdLap,
  });

  String toString() {
    return id.toString() +
        ' ' +
        dateTime.toString() +
        ' ' +
        firstLap.toString();
  }

  Record.fromMap(Map<String, dynamic> map) {
    id = map[Columns.id];
    dateTime = DateTime.fromMicrosecondsSinceEpoch(map[Columns.date]);
    firstLap = Lap(
      duration: Duration(microseconds: map[Columns.firstLap]),
      finishTime: Duration(microseconds: map[Columns.firstLap]),
    );
    secondLap = Lap(
      duration: Duration(microseconds: map[Columns.secondLap]),
      finishTime:
          Duration(microseconds: map[Columns.secondLap]) + firstLap.finishTime,
    );
    thirdLap = Lap(
      duration: Duration(microseconds: map[Columns.thirdLap]),
      finishTime:
          Duration(microseconds: map[Columns.thirdLap]) + secondLap.finishTime,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      if (id != null) Columns.id: id,
      Columns.date: (dateTime == null)
          ? DateTime.now().microsecondsSinceEpoch
          : dateTime.microsecondsSinceEpoch,
      Columns.firstLap: firstLap.duration.inMicroseconds,
      Columns.secondLap: secondLap.duration.inMicroseconds,
      Columns.thirdLap: thirdLap.duration.inMicroseconds,
    };
    return map;
  }

  bool get isEmpty =>
      id == null && firstLap == null && secondLap == null && thirdLap == null;
  bool get isNotEmpty => !isEmpty;
  bool get isFilled =>
      firstLap != null && secondLap != null && thirdLap != null;
  Duration get totalTime => thirdLap.finishTime;

  void clear() {
    id = null;
    dateTime = null;
    firstLap = null;
    secondLap = null;
    thirdLap = null;
  }
}
