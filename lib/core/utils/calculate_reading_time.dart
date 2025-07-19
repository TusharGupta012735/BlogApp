int calculateReadngTime(String content) {
  final words = content.split(RegExp(r'\s+')).length;
  final readingTime =
      (words / 200).ceil(); // Assuming average reading speed of 200 wpm
  return readingTime;
}
