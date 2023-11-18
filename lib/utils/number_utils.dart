import 'package:flutter_charging_station/utils/string_utils.dart';

class NumberUtils {
  static String stdFormat(double value) {
    String vString = value.toStringAsFixed(0);
    return StringUtils.replace(vString, '/\B(?=(\d{3})+(?!\d))/g', '.');
  }
}
