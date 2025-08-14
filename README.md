# News App (Flutter)

[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev) [![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)](https://dart.dev) [![BLoC](https://img.shields.io/badge/BLoC-Pattern-7B1FA2)](https://bloclibrary.dev) [![Dio](https://img.shields.io/badge/dio-HTTP-00796B)](https://pub.dev/packages/dio)

[![go_router](https://img.shields.io/badge/go__router-Navigation-0F9D58)](https://pub.dev/packages/go_router) [![json_serializable](https://img.shields.io/badge/json__serializable-Models-4EAA25)](https://pub.dev/packages/json_serializable) [![shared_preferences](https://img.shields.io/badge/shared__preferences-Storage-795548)](https://pub.dev/packages/shared_preferences) [![get_it](https://img.shields.io/badge/get__it-DI-455A64)](https://pub.dev/packages/get_it) [![equatable](https://img.shields.io/badge/equatable-%3D%3D-607D8B)](https://pub.dev/packages/equatable) [![intl](https://img.shields.io/badge/intl-i18n-03A9F4)](https://pub.dev/packages/intl)

Новостное приложение, в котором можно читать топ‑новости по категориям и быстро сохранять
понравившиеся в избранное.

## Возможности

- **Список новостей**: заголовок, подзаголовок, дата, изображение (если есть), ленивая подгрузка.
- **Поиск и фильтры**: строка поиска и категории (health, business, entertainment, general, science,
  sports, technology) — через API. Выбор категории взаимоисключающий: при выборе новой предыдущая
  снимается; повторный тап по активной — снимает фильтр.
- **Детали новости**: полный текст, источник, дата, изображение.
- **Избранное**: добавление/удаление, хранение в кэше (`shared_preferences`).
- **Обработка ошибок**: отсутствие интернета и ошибки API.
- **Локализация**: ru/en;

## Технический стек

- Flutter, Dart
- Управление состоянием: `flutter_bloc`
- DI: `get_it`
- Сеть: `dio`
- Генерация моделей: `json_serializable` + `build_runner`
- Навигация: `go_router`
- Локализация: `flutter_localizations` + ARB (`flutter gen-l10n`)

## Архитектура

Слоистая структура: `data` (DTO/mapper/service) → `infrastructure` (repository) → `bloc` → `ui`.

Ключевые решения:

- Слоистая архитектура: `data` → `infrastructure` → `bloc` → `ui` с явными контрактами.
- Репозитории инкапсулируют работу с сетью (`dio`) и отделяют UI от API.
- Строгие модели и маппинг: `json_serializable` + `equatable`.
- Единые сетевые настройки: базовые опции клиента и обработка ошибок.
- Локализация формата даты через шаблон в `.arb` + расширение `DateTime.toText(pattern:)`.
- DI через `get_it` — легко подменять зависимости.

## Дополнительные фичи

- Пагинация: постраничная подгрузка при скролле.
- Splash screen (iOS/Android).
- Иконки приложения для iOS/Android.
- Дебаунс запросов при изменении фильтров/поиска (350 мс) и отмена предыдущих запросов, чтобы не
  дергать API на каждое изменение.

## Дизайн

-
Макет: [Figma — flutter-test-task-design](https://www.figma.com/design/V068gxSJ91FNAPv9Rp6UVN/flutter-test-task-design?node-id=0-1&p=f&t=Ksz5Ym2CLRS8v53G-0)
- Dev Mode в макете недоступен, поэтому приложение не «pixel-perfect». Я ориентировалась на
  визуальное соответствие и поведение элементов.

## Быстрый запуск

1) Установить зависимости и сгенерировать код:

```bash
flutter pub get
flutter gen-l10n
flutter pub run build_runner build --delete-conflicting-outputs
```

2) Запустить, передав ключ NewsAPI:

```bash
flutter run --dart-define=api_key=YOUR_NEWS_API_KEY
```

Ключ читается из `String.fromEnvironment('api_key')` (см.
`lib/common/infrastructure/utils/api_key_holder.dart`).