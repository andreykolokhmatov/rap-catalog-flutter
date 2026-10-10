# Рэп-каталог — каркас на Flutter

ЛР2, веха В1. Тот же каталог хип-хоп исполнителей, что в ЛР1 на Compose Multiplatform,
переписанный на Flutter: домен, моки и макет прежние.

## Запуск

```bash
flutter pub get              # заодно генерирует lib/l10n/app_localizations*.dart
flutter run -d chrome        # браузер
flutter run -d windows       # второй таргет (на Linux: -d linux)
```

Если `flutter test`/`flutter run` падает на `WebSocketException ... 503`, системный
прокси перехватывает localhost: добавьте `127.0.0.1,localhost` в `NO_PROXY`.

## Источник данных

[MusicBrainz](https://musicbrainz.org/doc/MusicBrainz_API). Сети в ЛР2 нет: список живёт
на моках, **33 записи**, выгруженные из MusicBrainz (MBID, имена, страны, даты, теги,
дискографии). В ЛР3 моки заменит сеть, и поменяется только `features/artist/data`.

## Раскладка

| Путь | Что это |
|---|---|
| `lib/main.dart`, `lib/app.dart` | вход, корень: `RepositoryProvider` по интерфейсу, `MultiBlocProvider`, `MaterialApp.router` |
| `common/navigation/` | `go_router`: `/` — список, `/artist/:id` — деталь (вложена в список, поэтому глубокая ссылка тоже возвращает в список) |
| `common/settings/` | `SettingsCubit`: тема и язык, одно состояние с `copyWith`, живёт в памяти сессии |
| `common/theme/` | `AppColors` (палитры и цвета жанров), `ImageSources` (MBID → снимок), `AppTheme` |
| `common/widgets/` | шапка с переключателями, рамка ширины, секция, сообщение |
| `features/artist/domain/` | `ArtistModel` и вложенные модели, `IArtistRepository` |
| `features/artist/data/` | `ArtistRepository` на моках, `artist_mocks.dart` |
| `features/artist/presentation/bloc/` | `ArtistListCubit` и `ArtistDetailCubit`, состояния — `sealed` |
| `features/artist/presentation/view/` | экраны и их виджеты |
| `features/artist/presentation/utils/` | расширения для показа: подписи жанров, факты, год релиза |
| `lib/l10n/` | ARB на русском и английском |
| `assets/images/artists/` | 33 фото с Викисклада, авторы в `docs/CREDITS.md` |
| `tool/check_arb.dart` | сверяет ключи и параметры во всех ARB |

## Правила

**State manager — `flutter_bloc`, Cubit.** Событий у экранов мало и все они прямые
(«загрузи», «найди»), поэтому публичные методы Cubit проще событий Bloc и не теряют
в проверяемости. Экран рисует состояние и вызывает методы; навигацию делает виджет
через `context.push`, Cubit про неё не знает.

**Состояние — один неизменяемый тип.** Список: `Loading | Loaded(artists, query) | NotFound(query)`,
деталь: `Loading | Loaded(artist, related) | NotFound`. Противоречивых флагов нет.

**Строк и цветов в виджетах нет.** Подписи — в ARB, цвета — в `AppColors`/`ColorScheme`.
Проверка ARB:

```bash
dart run tool/check_arb.dart
```

**Данные каталога не переводятся.** Локализуется интерфейс. Исключение, как и в ЛР1, —
справка «Об исполнителе»: у неё есть отдельная русская версия (`biographyRu`), это первый
абзац статьи русской Википедии, а не перевод.

**Тема и язык не сохраняются на диск** — это не входит в веху.
