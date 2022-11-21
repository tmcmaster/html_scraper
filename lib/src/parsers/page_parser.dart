import 'dart:async';
import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:html_scraper/src/http/http_loader.dart';
import 'package:html_scraper/src/parsers/html_parser.dart';

class PageParser {
  static final TESTING = false;

  final String url;
  final Map<String, dynamic> headers;
  final bool verbose;
  final int successResponseCode;

  PageParser({
    required this.url,
    required this.headers,
    this.verbose = true,
    this.successResponseCode = 404,
  });

  Future<Map<String, T>> processAll<T>({
    Map<String, T Function(ElementParser document)>? processorMap,
    List<Map<String, T> Function(ElementParser document)>? processorList,
  }) async {
    final document = await loadDocument();
    final element = document?.body;
    final details = {
      if (processorMap != null)
        for (var key in processorMap.keys) key: processorMap[key]!(ElementParser(element)),
    };
    if (processorList != null) {
      processorList.forEach((processor) {
        details.addAll(processor(ElementParser(element)));
      });
    }
    return details;
  }

  Future<T> process<T>(dynamic Function(ElementParser elementParser) processor) async {
    final elementParser = await loadElementParser();
    return processor(elementParser);
  }

  Future<ElementParser> loadElementParser() async {
    final document = await loadDocument();
    final element = document == null ? null : document.body;
    return ElementParser(element);
  }

  Future<Document?> loadDocument() async {
    final responseString = await loadString();
    return responseString == null ? null : parse(responseString);
  }

  Future<String?> loadString() async {
    final response = await load();
    final body = response.body;
    final status = response.status;
    final success = status == 200;

    if (TESTING) await File('junk/junk3.html').writeAsString(body);

    return success ? body : '';
  }

  Future<HttpLoaderResponse> load() async {
    // print('Loading page: url($url)');
    final loader = HttpLoader.http(url, headers);
    return await loader.load();
  }
}
