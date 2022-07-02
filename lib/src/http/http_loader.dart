import 'package:html_scraper/src/http/http_loader_dio.dart';
import 'package:html_scraper/src/http/http_loader_http.dart';

abstract class HttpLoader {
  final String url;
  final Map<String, dynamic> headers;
  final bool verbose;

  HttpLoader({
    required this.url,
    required this.headers,
    this.verbose = false,
  });

  factory HttpLoader.dio(String url, Map<String, dynamic> headers) {
    return HttpLoaderDio(url: url, headers: headers);
  }

  factory HttpLoader.http(String url, Map<String, dynamic> headers) {
    return HttpLoaderHttp(url: url, headers: headers);
  }

  // Future<HttpLoaderResponse> load() async {
  //   print('-> About to load: $url');
  //
  //   try {
  //     return _load();
  //   } catch (error, stacktrace) {
  //     if (verbose) print('ERROR: There was an error while loading page($url): $error\n$stacktrace');
  //     return HttpLoaderResponse(
  //       body: '',
  //       status: 404,
  //     );
  //   }
  // }

  Future<HttpLoaderResponse> load();

  // Future<HttpLoaderResponse> _load2() async {
  //   final response = await Dio().get(
  //     url,
  //     options: Options(
  //       headers: headers,
  //     ),
  //   );
  //   return HttpLoaderResponse(body: response.data, status: response.statusCode ?? 404);
  // }
}

class HttpLoaderResponse {
  final String body;
  final int status;

  HttpLoaderResponse({
    required this.body,
    required this.status,
  });
}
