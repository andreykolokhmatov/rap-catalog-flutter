# Источники изображений и текстов

## Фото исполнителей

Своих снимков в проекте нет: с ЛР3 фото приходит из сети у всех исполнителей
одинаково. Это фото из Викиданных (свойство P18 у элемента с MBID исполнителя, P434),
оно грузится миниатюрой 330px прямо с `upload.wikimedia.org` (Викисклад).

Лицензии у этих снимков свободные, но большинство требует указания автора. Автор и
лицензия каждого снимка указаны на странице файла на Викискладе, ссылку на неё даёт
сам адрес картинки. Если в Викиданных фото нет, рисуется буквенная плитка на
градиенте цветов жанров.

В ЛР2 сети не было, поэтому 33 снимка лежали в `assets/images/artists` с таблицей
авторов в этом файле. В ЛР3 они убраны: иначе у этих 33 исполнителей фото бралось бы
из другого источника, чем у остальных.

## Данные каталога

Данные каталога — имена, страны, даты, теги, дискографии — из
[MusicBrainz](https://musicbrainz.org/), лицензия базы CC0.

## Тексты справок

Биографии на экране детали — первый абзац статьи английской Википедии, поле
`ArtistModel.biography`. Лицензия текста — [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/),
авторы указаны в истории правок соответствующей статьи.

Из MusicBrainz этот текст не приходит: тамошний `annotation` — служебная заметка
редакторов базы, а не справка для читателя. В ЛР3 биография достаётся в два шага,
оба звена настоящие: у записи MusicBrainz есть связь с Викиданными
(`inc=url-rels`), у элемента Викиданных — ссылка на статью, у Википедии —
`REST /page/summary/{title}`.

| Артист | Статья |
|---|---|
| 21 Savage | [21 Savage](https://en.wikipedia.org/wiki/21_Savage) |
| 2Pac | [Tupac Shakur](https://en.wikipedia.org/wiki/Tupac_Shakur) |
| 50 Cent | [50 Cent](https://en.wikipedia.org/wiki/50_Cent) |
| A Tribe Called Quest | [A Tribe Called Quest](https://en.wikipedia.org/wiki/A_Tribe_Called_Quest) |
| Beastie Boys | [Beastie Boys](https://en.wikipedia.org/wiki/Beastie_Boys) |
| Busta Rhymes | [Busta Rhymes](https://en.wikipedia.org/wiki/Busta_Rhymes) |
| Cypress Hill | [Cypress Hill](https://en.wikipedia.org/wiki/Cypress_Hill) |
| De La Soul | [De La Soul](https://en.wikipedia.org/wiki/De_La_Soul) |
| Drake | [Drake (musician)](https://en.wikipedia.org/wiki/Drake_(musician)) |
| Eminem | [Eminem](https://en.wikipedia.org/wiki/Eminem) |
| Future | [Future (rapper)](https://en.wikipedia.org/wiki/Future_(rapper)) |
| Gucci Mane | [Gucci Mane](https://en.wikipedia.org/wiki/Gucci_Mane) |
| Ice Cube | [Ice Cube](https://en.wikipedia.org/wiki/Ice_Cube) |
| J. Cole | [J. Cole](https://en.wikipedia.org/wiki/J._Cole) |
| Juice WRLD | [Juice Wrld](https://en.wikipedia.org/wiki/Juice_Wrld) |
| Ken Carson | [Ken Carson](https://en.wikipedia.org/wiki/Ken_Carson) |
| Kendrick Lamar | [Kendrick Lamar](https://en.wikipedia.org/wiki/Kendrick_Lamar) |
| Lil Uzi Vert | [Lil Uzi Vert](https://en.wikipedia.org/wiki/Lil_Uzi_Vert) |
| Lil Wayne | [Lil Wayne](https://en.wikipedia.org/wiki/Lil_Wayne) |
| Madlib | [Madlib](https://en.wikipedia.org/wiki/Madlib) |
| MF DOOM | [MF Doom](https://en.wikipedia.org/wiki/MF_Doom) |
| Nas | [Nas](https://en.wikipedia.org/wiki/Nas) |
| OutKast | [Outkast](https://en.wikipedia.org/wiki/Outkast) |
| Playboi Carti | [Playboi Carti](https://en.wikipedia.org/wiki/Playboi_Carti) |
| Public Enemy | [Public Enemy](https://en.wikipedia.org/wiki/Public_Enemy) |
| Rae Sremmurd | [Rae Sremmurd](https://en.wikipedia.org/wiki/Rae_Sremmurd) |
| Run‐D.M.C. | [Run-DMC](https://en.wikipedia.org/wiki/Run-DMC) |
| Snoop Dogg | [Snoop Dogg](https://en.wikipedia.org/wiki/Snoop_Dogg) |
| Travis Scott | [Travis Scott](https://en.wikipedia.org/wiki/Travis_Scott) |
| Trippie Redd | [Trippie Redd](https://en.wikipedia.org/wiki/Trippie_Redd) |
| Wu‐Tang Clan | [Wu-Tang Clan](https://en.wikipedia.org/wiki/Wu-Tang_Clan) |
| XXXTENTACION | [XXXTentacion](https://en.wikipedia.org/wiki/XXXTentacion) |
| Ye | [Kanye West](https://en.wikipedia.org/wiki/Kanye_West) |

Русские справки — первый абзац статьи русской Википедии, поле `ArtistModel.biographyRu`.
Это не перевод английского текста: у русской Википедии свои авторы и своя редакция.
Лицензия та же, CC BY-SA 4.0.

| Артист | Статья (ru) |
|---|---|
| 21 Savage | [21 Savage](https://ru.wikipedia.org/wiki/21_Savage) |
| 2Pac | [Шакур, Тупак](https://ru.wikipedia.org/wiki/%D0%A8%D0%B0%D0%BA%D1%83%D1%80%2C_%D0%A2%D1%83%D0%BF%D0%B0%D0%BA) |
| 50 Cent | [50 Cent](https://ru.wikipedia.org/wiki/50_Cent) |
| A Tribe Called Quest | [A Tribe Called Quest](https://ru.wikipedia.org/wiki/A_Tribe_Called_Quest) |
| Beastie Boys | [Beastie Boys](https://ru.wikipedia.org/wiki/Beastie_Boys) |
| Busta Rhymes | [Баста Раймс](https://ru.wikipedia.org/wiki/%D0%91%D0%B0%D1%81%D1%82%D0%B0_%D0%A0%D0%B0%D0%B9%D0%BC%D1%81) |
| Cypress Hill | [Cypress Hill](https://ru.wikipedia.org/wiki/Cypress_Hill) |
| De La Soul | [De La Soul](https://ru.wikipedia.org/wiki/De_La_Soul) |
| Drake | [Дрейк (рэпер)](https://ru.wikipedia.org/wiki/%D0%94%D1%80%D0%B5%D0%B9%D0%BA_%28%D1%80%D1%8D%D0%BF%D0%B5%D1%80%29) |
| Eminem | [Эминем](https://ru.wikipedia.org/wiki/%D0%AD%D0%BC%D0%B8%D0%BD%D0%B5%D0%BC) |
| Future | [Фьючер](https://ru.wikipedia.org/wiki/%D0%A4%D1%8C%D1%8E%D1%87%D0%B5%D1%80) |
| Gucci Mane | [Гуччи Мейн](https://ru.wikipedia.org/wiki/%D0%93%D1%83%D1%87%D1%87%D0%B8_%D0%9C%D0%B5%D0%B9%D0%BD) |
| Ice Cube | [Айс Кьюб](https://ru.wikipedia.org/wiki/%D0%90%D0%B9%D1%81_%D0%9A%D1%8C%D1%8E%D0%B1) |
| J. Cole | [Коул, Джей](https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D1%83%D0%BB%2C_%D0%94%D0%B6%D0%B5%D0%B9) |
| Juice WRLD | [Juice WRLD](https://ru.wikipedia.org/wiki/Juice_WRLD) |
| Ken Carson | [Ken Carson](https://ru.wikipedia.org/wiki/Ken_Carson) |
| Kendrick Lamar | [Кендрик Ламар](https://ru.wikipedia.org/wiki/%D0%9A%D0%B5%D0%BD%D0%B4%D1%80%D0%B8%D0%BA_%D0%9B%D0%B0%D0%BC%D0%B0%D1%80) |
| Lil Uzi Vert | [Lil Uzi Vert](https://ru.wikipedia.org/wiki/Lil_Uzi_Vert) |
| Lil Wayne | [Лил Уэйн](https://ru.wikipedia.org/wiki/%D0%9B%D0%B8%D0%BB_%D0%A3%D1%8D%D0%B9%D0%BD) |
| Madlib | [Madlib](https://ru.wikipedia.org/wiki/Madlib) |
| MF DOOM | [MF Doom](https://ru.wikipedia.org/wiki/MF_Doom) |
| Nas | [Нас (рэпер)](https://ru.wikipedia.org/wiki/%D0%9D%D0%B0%D1%81_%28%D1%80%D1%8D%D0%BF%D0%B5%D1%80%29) |
| OutKast | [Outkast](https://ru.wikipedia.org/wiki/Outkast) |
| Playboi Carti | [Playboi Carti](https://ru.wikipedia.org/wiki/Playboi_Carti) |
| Public Enemy | [Public Enemy](https://ru.wikipedia.org/wiki/Public_Enemy) |
| Rae Sremmurd | [Rae Sremmurd](https://ru.wikipedia.org/wiki/Rae_Sremmurd) |
| Run‐D.M.C. | [Run-DMC](https://ru.wikipedia.org/wiki/Run-DMC) |
| Snoop Dogg | [Snoop Dogg](https://ru.wikipedia.org/wiki/Snoop_Dogg) |
| Travis Scott | [Трэвис Скотт (рэпер)](https://ru.wikipedia.org/wiki/%D0%A2%D1%80%D1%8D%D0%B2%D0%B8%D1%81_%D0%A1%D0%BA%D0%BE%D1%82%D1%82_%28%D1%80%D1%8D%D0%BF%D0%B5%D1%80%29) |
| Trippie Redd | [Trippie Redd](https://ru.wikipedia.org/wiki/Trippie_Redd) |
| Wu‐Tang Clan | [Wu-Tang Clan](https://ru.wikipedia.org/wiki/Wu-Tang_Clan) |
| XXXTENTACION | [XXXTentacion](https://ru.wikipedia.org/wiki/XXXTentacion) |
| Ye | [Уэст, Канье](https://ru.wikipedia.org/wiki/%D0%A3%D1%8D%D1%81%D1%82%2C_%D0%9A%D0%B0%D0%BD%D1%8C%D0%B5) |

## Иконки

Иконки интерфейса — Material Icons из Flutter SDK (Google, Apache License 2.0).
