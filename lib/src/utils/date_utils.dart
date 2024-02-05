
class DateUtils {
  static String convertToDate(String date) {
    List<String> dateParts = date.split('/');
    return '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';
  }
}
