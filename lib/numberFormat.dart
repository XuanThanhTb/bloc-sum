import 'package:intl/intl.dart';

class NumberUtil {
  static var numberFormat = new NumberFormat("###,###,###", "en_US");
  static String money(int num) => '₫ ' + numberFormat.format(num);
}