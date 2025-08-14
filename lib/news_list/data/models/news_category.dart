import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  String get key => 'category_$name';

  String title(AppLocalizations l) {
    switch (this) {
      case NewsCategory.business:
        return l.category_business;
      case NewsCategory.general:
        return l.category_general;
      case NewsCategory.science:
        return l.category_science;
      case NewsCategory.entertainment:
        return l.category_entertainment;
      case NewsCategory.health:
        return l.category_health;
      case NewsCategory.sports:
        return l.category_sports;
      case NewsCategory.technology:
        return l.category_technology;
    }
  }
}
