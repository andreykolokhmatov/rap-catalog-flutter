// Сверяет ключи и имена параметров во всех ARB: gen_l10n о пропусках молчит.
// Запуск: dart run tool/check_arb.dart
import 'dart:convert';
import 'dart:io';

void main() {
  final files = Directory('lib/l10n')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.arb'))
      .toList();
  final arbs = {
    for (final f in files)
      f.uri.pathSegments.last:
          (jsonDecode(f.readAsStringSync()) as Map<String, dynamic>)
            ..removeWhere((k, _) => k.startsWith('@')),
  };

  final placeholder = RegExp(r'\{(\w+)\}');
  Set<String> paramsOf(String text) =>
      placeholder.allMatches(text).map((m) => m.group(1)!).toSet();

  final allKeys = arbs.values.expand((m) => m.keys).toSet();
  var problems = 0;
  for (final key in allKeys) {
    final present = {
      for (final e in arbs.entries)
        if (e.value.containsKey(key)) e.key: paramsOf(e.value[key] as String),
    };
    final missing = arbs.keys.where((f) => !present.containsKey(f));
    if (missing.isNotEmpty) {
      stdout.writeln('$key: нет в ${missing.join(', ')}');
      problems++;
    }
    final signatures = present.values
        .map((p) => (p.toList()..sort()).join(','))
        .toSet();
    if (signatures.length > 1) {
      stdout.writeln('$key: параметры расходятся $present');
      problems++;
    }
  }

  if (problems == 0) {
    stdout.writeln(
      'ARB в порядке: ${arbs.length} файла, ${allKeys.length} ключей',
    );
  } else {
    exitCode = 1;
  }
}
