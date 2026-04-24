class DateParser {
  static String? extractDate(String input) {
    final regex = RegExp(r'(\d{4})[-/](\d{2})[-/](\d{2})');
    final match = regex.firstMatch(input);

    if (match != null) {
      return '${match.group(1)}-${match.group(2)}-${match.group(3)}';
    }
    
    return null;
  }
}