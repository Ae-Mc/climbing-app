String stringFromDuration(final Duration duration) {
  String s = duration.toString();
  s = s.substring(0, s.length - 4);
  if (duration.inHours == 0)
    s = s.substring(2);
  else if (duration.inHours < 10) s = '0' + s;
  return s;
}
