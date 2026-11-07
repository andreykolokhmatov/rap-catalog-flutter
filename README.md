# Рэп-каталог — каркас на Flutter

Тот же каталог хип-хоп исполнителей, что в ЛР1 на Compose Multiplatform, на Flutter.
ЛР2 — каркас на моках, ЛР3 — данные из сети.

## Запуск

```bash
flutter pub get              # заодно генерирует lib/l10n/app_localizations*.dart
dart run build_runner build --delete-conflicting-outputs   # после правки DTO
flutter run -d chrome        # браузер
flutter run -d windows       # второй таргет (на Linux: -d linux)
```

Если `flutter test`/`flutter run` падает на `WebSocketException ... 503`, системный
прокси перехватывает localhost: добавьте `127.0.0.1,localhost` в `NO_PROXY`.

## Источник данных

[MusicBrainz](https://musicbrainz.org/doc/MusicBrainz_API), как в ЛР1. Моков больше нет.

| Что | Запрос |
|---|---|
| список и поиск | `GET artist?query=tag:"hip hop" AND tag:rap AND (type:person OR type:group) [AND artist:(слово*)]&limit=30&offset=…` |
| деталь | `GET artist/{id}?inc=aliases+tags+artist-rels+url-rels+release-groups&type=album` |
| справка «Об исполнителе» | Викиданные `wbgetentities` → параллельно `en/ru.wikipedia.org/api/rest_v1/page/summary/{title}` |
| фото | `query.wikidata.org/sparql`: P18 у элементов с MBID (P434), один запрос на страницу списка или на деталь со связанными |

MusicBrainz пускает не чаще запроса в секунду, иначе отвечает 503. Поэтому запросы к нему
идут через очередь в `DioClient` (интервал 1,1 с), поиск отправляется через 400 мс после
последнего нажатия, а связанные исполнители берутся из связей в ответе детали, без отдельных
запросов. На 503 экран показывает «слишком много запросов» и «Повторить».

Жанры — теги MusicBrainz, которые совпадают с жанрами каталога (`Genre`), по убыванию голосов.
Фото: у 33 исполнителей из ЛР2 — локальные снимки, у остальных — миниатюра с Викисклада
по фото из Викиданных. Адрес миниатюры собирается из MD5 имени файла: `Special:FilePath`
отвечает редиректами без CORS, и в браузере картинка не загрузилась бы. Нет фото
в Викиданных — буквенная плитка. Справка и фото — дополнения с других серверов:
их сбой не роняет экран, сбой MusicBrainz — роняет.

## Раскладка

| Путь | Что это |
|---|---|
| `lib/main.dart`, `lib/app.dart` | вход, корень: `Dio` → API → датасорс → `RepositoryProvider` по интерфейсу, `MultiBlocProvider`, `MaterialApp.router` |
| `common/network/` | `DioClient` (базовый адрес, таймауты, очередь к MusicBrainz, `LogInterceptor` в debug), `sealed LoadException` |
| `common/navigation/` | `go_router`: `/` — список, `/artist/:id` — деталь (вложена в список, поэтому глубокая ссылка тоже возвращает в список) |
| `common/settings/` | `SettingsCubit`: тема и язык, одно состояние с `copyWith`, живёт в памяти сессии |
| `common/theme/` | `AppColors` (палитры и цвета жанров), `ImageSources` (MBID → снимок), `AppTheme` |
| `common/widgets/` | шапка с переключателями, рамка ширины, секция, сообщение, ошибка с «Повторить» |
| `features/artist/domain/` | `ArtistModel` и вложенные модели, `ArtistPage`, `IArtistRepository` |
| `features/artist/data/api/` | `ArtistApi` (MusicBrainz), `WikiApi` (Викиданные, Википедия): метод на адрес, возвращают DTO |
| `features/artist/data/dto/` | DTO на `json_serializable`, `*.g.dart` в git |
| `features/artist/data/data_sources/` | `IArtistDataSource`, `NetworkArtistDataSource`: запрос Lucene, `DioException` → `LoadException` |
| `features/artist/data/mappers/` | `ArtistDtoMapper.toModel()`: теги → жанры, альбомы, псевдонимы, связанные; `WikidataImagesMapper`: адреса миниатюр |
| `features/artist/data/artist_repository.dart` | DTO → модель, справка из Википедии, фото из Викиданных |
| `features/artist/presentation/bloc/` | `ArtistListCubit` и `ArtistDetailCubit`, состояния — `sealed` |
| `features/artist/presentation/view/` | экраны и их виджеты |
| `features/artist/presentation/utils/` | расширения для показа: подписи жанров, факты, год релиза, текст ошибки |
| `lib/l10n/` | ARB на русском и английском |
| `assets/images/artists/` | 33 фото с Викисклада, авторы в `docs/CREDITS.md` |
| `tool/check_arb.dart` | сверяет ключи и параметры во всех ARB |

## Правила

**State manager — `flutter_bloc`, Cubit.** Событий у экранов мало и все они прямые
(«загрузи», «найди»), поэтому публичные методы Cubit проще событий Bloc и не теряют
в проверяемости. Экран рисует состояние и вызывает методы; навигацию делает виджет
через `context.push`, Cubit про неё не знает.

**Состояние — один неизменяемый тип.** Список: `Loading(query) | Loaded(artists, query, total, nextOffset, nextPage) | NotFound(query) | Error(query, error)`,
где `nextPage` — `idle | loading | error` догрузки под списком. Деталь: `Loading | Loaded(artist, related) | NotFound | Error(error)`.
Противоречивых флагов нет.

**Ошибка — не пустой список.** Data-слой бросает `LoadException` наверх, Cubit кладёт её
в `Error`, экран показывает сообщение и «Повторить». Про `dio` и DTO Cubit не знает.
Исключение — справка и фото из Википедии и Викиданных: это дополнения с других серверов, их сбой экран не роняет.

**Строк и цветов в виджетах нет.** Подписи — в ARB, цвета — в `AppColors`/`ColorScheme`.
Проверка ARB:

```bash
dart run tool/check_arb.dart
```

**Данные каталога не переводятся.** Локализуется интерфейс. Исключение, как и в ЛР1, —
справка «Об исполнителе»: у неё есть отдельная русская версия (`biographyRu`), это первый
абзац статьи русской Википедии, а не перевод.

**Тема и язык не сохраняются на диск** — это не входит в веху.
