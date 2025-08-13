import 'package:json_annotation/json_annotation.dart';

enum NewsCategory {
  @JsonValue('business')
  business,
  @JsonValue('general')
  general,
  @JsonValue('science')
  science,
  @JsonValue('entertainment')
  entertainment,
  @JsonValue('health')
  health,
  @JsonValue('sports')
  sports,
  @JsonValue('technology')
  technology;

  String get displayTitle {
    final s = name;
    return s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
  }
}
