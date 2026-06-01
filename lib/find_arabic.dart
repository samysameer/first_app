import 'dart:io';

void main() async {
  final dir = Directory('c:/development/flutter-app/first_app/lib');
  final regex = RegExp(r"(?:l10n\.)?isArabic(?:\(context\))?\s*\?\s*'([^']+)'\s*:\s*'([^']+)'");
  
  Map<String, String> replacements = {};
  
  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final content = await entity.readAsString();
      final matches = regex.allMatches(content);
      for (final match in matches) {
        String ar = match.group(1)!;
        String en = match.group(2)!;
        String key = en.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
        key = key.substring(0, 1).toLowerCase() + key.substring(1);
        if (key.length > 20) key = key.substring(0, 20);
        replacements[key] = "$ar | $en";
      }
    }
  }
  
  for (var k in replacements.keys) {
    print("$k : ${replacements[k]}");
  }
}
