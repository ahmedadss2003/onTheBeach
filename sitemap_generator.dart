import 'dart:io';

void main() async {
  final file = File('sitemap.xml');

  if (!await file.exists()) {
    print('❌ File not found!');
    return;
  }

  String content = await file.readAsString();

  // استبدال place_details بـ place-details
  content = content.replaceAll('place_details', 'place-details');

  await file.writeAsString(content);

  print('✅ All links updated successfully in sitemap.xml');
}
