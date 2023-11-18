class StringUtils {
  static String replace(
          String inputText, String pattern, String strReplacePattern) =>
      inputText.replaceAllMapped(RegExp(pattern), (match) {
        var replacedString = strReplacePattern;
        for (var i = 0; i <= match.groupCount; i++) {
          replacedString = replacedString.replaceAll('\$$i', match.group(i)!);
        }
        return replacedString;
      });
}
