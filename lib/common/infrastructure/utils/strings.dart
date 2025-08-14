class Strings {
  final Map<String, String> _strings;

  Strings({required Map<String, String> strings}) : _strings = strings;

  String textByKey(String key, {String fallback = ''}) => _strings[key] ?? fallback;
}
