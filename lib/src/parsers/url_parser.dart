class URLParser {
  final String? url;
  final int? segment;
  final String? separator;

  URLParser({
    this.url,
    this.segment,
    this.separator,
  });

  String? parse() {
    if (url == null) return null;
    if (separator != null) {
      return _parseWithSeparator(url!, separator!, segment);
    }
    return url;
  }

  String? _parseWithSeparator(String url, String separator, int? segment) {
    final parts = url.split(separator);
    if (parts.length < 2) return null;
    final requiredSegment = segment ?? parts.length - 1;
    if (parts.length - 1 < requiredSegment) return null;
    final value = parts[requiredSegment];
    if (value.isEmpty) return null;
    return value.endsWith('/') ? value.substring(0, value.length - 1) : value;
  }
}
