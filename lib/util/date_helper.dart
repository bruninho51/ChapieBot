class DateHelper {
  
  static int currentTimeInSeconds() {
    var ms = (new DateTime.now()).millisecondsSinceEpoch;
    return (ms / 1000).round();
  } 

  static DateTime secondsToDateTime(int seconds) {
    var ms = seconds * 1000;
    return new DateTime.fromMillisecondsSinceEpoch(ms);
  }

  static int dateTimeToSeconds(DateTime dateTime) {
    var ms = dateTime.millisecondsSinceEpoch;
    return (ms / 1000).round();
  }
}