import 'package:intl/intl.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2021/03/29 15:46
/// email zdl328465042@163.com
/// description 时间相关
class ZTimeUtil {
  const ZTimeUtil._();

  static DateTime _now = DateTime.now();

  /// 获取年
  static int get getYear => _now.year;

  /// 获取月
  static int get getMonth => _now.month;

  /// 获取日
  static int get getDay => _now.day;

  /// 获取时
  static int get getHour => _now.hour;

  /// 获取分
  static int get getMinute => _now.minute;

  /// 获取秒
  static int get getSecond => _now.second;

  /// 获取时间戳-秒
  static int get getTimestamp => getTimestampMilli ~/ 1000;

  /// 获取时间戳-毫秒
  static int get getTimestampMilli => _now.millisecondsSinceEpoch;

  /// 获取周几
  static int get getWeekday => _now.weekday;

  /// 获取当前时间
  /// [isStart] null:当前时间；true:今天开始时间；false:今天结束时间
  static DateTime getCurrentDay({bool? isStart}) {
    return isStart == null ? _now : (isStart ? _now.theDayStart : _now.theDayEnd);
  }

  /// 获取季度
  /// [month] 指定解析月份
  static int getQuarter(int month) {
    assert(month.isMonth, '解析月份不正确，当前解析的月份为($month)');
    return (month / 3).ceil();
  }

  /// 在当前时间下，指定往前、往后几天
  /// [days] = 0，为今天；> 0，为往后多少天；< 0，为往前几天
  static DateTime getAssignDay(int days) {
    return days >= 0 ? _now.add(Duration(days: days)).theDayEnd : _now.subtract(Duration(days: days.abs())).theDayStart;
  }

  /// 字符串转DateTime
  static DateTime str2date(String dateStr, [String format = ZTimeFormat.def]) {
    var df = DateFormat(format);
    try {
      return df.parse(dateStr);
    } catch (_) {
      throw ('字符串格式与format不匹配，当前字符串($dateStr)，当前format($format)');
    }
  }

  /// 时间戳转DateTime
  static DateTime time2date(int time, [String format = ZTimeFormat.def]) {
    var timeLength = time.toString().length;
    assert(timeLength == 10 || timeLength == 13, '时间戳长度不正确，当前时间戳为($time)');
    return DateTime.fromMillisecondsSinceEpoch(timeLength == 10 ? time * 1000 : time);
  }

  /// 获取间隔天数
  static int getIntervalDay(DateTime date1, DateTime date2) {
    return date1.difference(date2).inDays.abs();
  }

  /// 获取周开始结束时间
  static DateTime getWeekStartOrEnd(bool isStart, {int? year, int? month, int? day}) {
    if (year == null) year = getYear;
    if (month == null) month = getMonth;
    if (day == null) day = getDay;
    var weekday = DateTime(year, month, day).weekday;
    //dart已经处理了日期负数和超出31的情况，比如day为负数，则DateTime会往前多少天，超出31自动计算跳几个月
    return isStart ? DateTime(year, month, day - weekday).theDayStart : DateTime(year, month, day + (7 - weekday)).theDayEnd;
  }

  /// 获取月开始结束时间
  static DateTime getMonthStartOrEnd(bool isStart, {int? year, int? month}) {
    if (year == null) year = getYear;
    if (month == null) month = getMonth;
    //dart已经处理了月份超出12的情况，比如month+1为12+1，则DateTime会跳到下一年1月
    return isStart ? DateTime(year, month, 1).theDayStart : DateTime(year, month + 1, 1).theDayEnd.subtract(Duration(days: 1));
  }

  /// 获取季度开始结束时间
  static DateTime getQuarterStartOrEnd(bool isStart, {int? year, int? quarter}) {
    if (year == null) year = getYear;
    if (quarter != null)
      assert(quarter >= 1 && quarter <= 4, '季度不正确，当前季度为($quarter)');
    else
      quarter = getQuarter(getMonth);
    return getMonthStartOrEnd(isStart, year: year, month: isStart ? (quarter * 3) - 2 : quarter * 3);
  }

  /// 判断指定月份是否存在指定日期
  static bool monthHasDay(int month, int day) => DateTime(getYear, month, day).month == month;
}

class ZTimeFormat {
  const ZTimeFormat._();

  static const String def = 'yyyy-MM-dd HH:mm:ss';
  static const String def_zh = 'yyyy年MM月dd日 HH点mm分ss秒';
  static const String ymd_hm = 'yyyy-MM-dd HH:mm';
  static const String ymd_hm_zh = 'yyyy年MM月dd日 HH点mm分';
  static const String ymd = 'yyyy-MM-dd';
  static const String ymd_zh = 'yyyy年MM月dd日';
  static const String md = 'MM-dd';
  static const String md_zh = 'MM月dd日';
  static const String hms = 'HH:mm:ss';
  static const String hms_zh = 'HH点mm分ss秒';
  static const String rfc3339 = 'yyyy-MM-dd\'T\'HH:mm:ss\'.0Z\'';
}
