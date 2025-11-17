import 'dart:convert';
import 'dart:io';

final inputDir = Directory('lib/l10n/object');
final outputDir = Directory('lib/l10n');

List<String> _extractPlaceholders(String s) {
  final reg = RegExp(r"\{(.*?)\}");
  return reg.allMatches(s).map((m) => m.group(1)!).toList();
}

void flatten(Map map, String prefix, Map<String, dynamic> out) {
  map.forEach((k, v) {
    final newKey = prefix.isEmpty ? k : "${prefix}_${k}";
    if (v is Map) {
      flatten(v, newKey, out);
    } else {
      out[newKey] = v?.toString();
      // metadata will be generated later
    }
  });
}

Future<void> main(List<String> args) async {
  if (!inputDir.existsSync()) {
    print('Folder not found: lib/l10n/object');
    exit(1);
  }
  if (!outputDir.existsSync()) outputDir.createSync(recursive: true);

  for (var f in inputDir.listSync()) {
    if (f is! File) continue;
    if (!f.path.endsWith('.json')) continue;

    final name = f.uri.pathSegments.last.replaceAll('.json', ''); // e.g. app_en
    final locale = name.split('_').last; // en or id
    final content = json.decode(await f.readAsString()) as Map;

    final flat = <String, dynamic>{};
    flatten(content, '', flat);

    // prepare arb map with locale meta and placeholders metadata
    final arb = <String, dynamic>{'@@locale': locale};

    flat.forEach((k, v) {
      arb[k] = v;

      // detect placeholders and add metadata
      final placeholders = _extractPlaceholders(v ?? '');
      if (placeholders.isNotEmpty) {
        final meta = <String, dynamic>{
          'description': k.replaceAll('_', ' ') + ' (auto-generated)',
          'placeholders': {for (var p in placeholders) p: {}},
        };
        arb['@$k'] = meta;
      }
    });

    final outPath = '${outputDir.path}/$name.arb'; // lib/l10n/app_en.arb
    final outFile = File(outPath);
    await outFile.writeAsString(const JsonEncoder.withIndent('  ').convert(arb));
    print('Generated $outPath');
  }

  print('Done converting JSON -> ARB');
}
