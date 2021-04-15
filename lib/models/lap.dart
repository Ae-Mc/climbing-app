class Lap {
  final Duration duration;
  final Duration finishTime;

  Lap({
    this.duration = Duration.zero,
    this.finishTime = Duration.zero,
  });

  @override
  String toString() {
    return duration.toString();
  }
}
