import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../dto/wiki_dto.dart';

extension WikidataImagesMapper on WikidataImagesDto {
  static const _thumbWidth = 330;

  /// MBID → адрес миниатюры на upload.wikimedia.org. У исполнителя может быть
  /// несколько фото, берётся первое.
  Map<String, String> toPhotoUrls() {
    final urls = <String, String>{};
    for (final row in results.bindings) {
      final url = _thumbUrl(row.image.value);
      if (url != null) urls.putIfAbsent(row.mbid.value, () => url);
    }
    return urls;
  }

  // Викиданные отдают Special:FilePath, а он отвечает редиректами без заголовка CORS,
  // и в браузере картинка не загрузится. Прямой адрес миниатюры Викисклада строится
  // из MD5 имени файла: thumb/a/ab/Имя/330px-Имя.
  static String? _thumbUrl(String filePath) {
    const marker = 'Special:FilePath/';
    final at = filePath.indexOf(marker);
    if (at < 0) return null;
    final name = Uri.decodeComponent(filePath.substring(at + marker.length))
        .replaceAll(' ', '_');
    final hash = md5.convert(utf8.encode(name)).toString();
    final encoded = Uri.encodeComponent(name);
    // Миниатюра SVG и TIFF отдаётся растром.
    final suffix = switch (name.split('.').last.toLowerCase()) {
      'svg' => '.png',
      'tif' || 'tiff' => '.jpg',
      _ => '',
    };
    return 'https://upload.wikimedia.org/wikipedia/commons/thumb/'
        '${hash[0]}/${hash.substring(0, 2)}/$encoded/'
        '${_thumbWidth}px-$encoded$suffix';
  }
}
