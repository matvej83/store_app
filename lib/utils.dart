class AppUtils {
  static String getFirstLetter(String name) {
    if (name.isEmpty) return '';
    return name.substring(0, 1);
  }

  static String getFirstName(String name) {
    if (name.isEmpty) return '';
    return name.split(' ').first;
  }

  static String getLastName(String name) {
    if (name.isEmpty) return '';
    return name.split(' ').last;
  }
}
