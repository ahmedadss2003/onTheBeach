String slugify(String text) {
  return text
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '') // استبدل الرموز بـ _
      .replaceAll(RegExp(r'(^_|_$)'), ''); // يشيل _ في البداية والنهاية
}
