import 'package:html_scraper/src/http/http_loader.dart';
import 'package:http/http.dart' as http;

class HttpLoaderHttp extends HttpLoader {
  HttpLoaderHttp({
    required String url,
    required Map<String, dynamic> headers,
    bool verbose = false,
  }) : super(
          url: url,
          headers: headers,
          verbose: verbose,
        );

  @override
  Future<HttpLoaderResponse> load() async {
    final newHeaders = {for (var key in headers.keys) key: headers[key].toString()};
    if (verbose) print('URL: $url');
    if (verbose) print('HEADERS: $newHeaders');
    try {
      final response = await http.get(Uri.parse(url), headers: newHeaders);

      print('-< Response Received: $url');
      return HttpLoaderResponse(
        body: response.body,
        status: response.statusCode,
      );
    } catch (error) {
      print('ERROR: URL($url): $error');
      return HttpLoaderResponse(
        body: '',
        status: 500,
      );
    }
  }
}
