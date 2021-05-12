/// @author zdl
/// date 2021/03/30 18:11
/// email zdl328465042@163.com
/// description 扩展List
extension ExtensionList on List {
  /// 拆分列表后拼接为字符串
  String toStringWith({String splitUnit = '、', String def = '无'}) {
    String str = this.toString();
    return (this ?? []).isEmpty ? def : str.substring(1, str.length - 1).replaceAll(', ', splitUnit);
  }
}
