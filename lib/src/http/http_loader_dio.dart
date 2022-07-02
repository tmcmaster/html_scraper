import 'package:dio/dio.dart';
import 'package:html_scraper/src/http/http_loader.dart';

class HttpLoaderDio extends HttpLoader {
  HttpLoaderDio({
    required String url,
    required Map<String, dynamic> headers,
    bool verbose = false,
  }) : super(
          url: url,
          headers: headers,
          verbose: verbose,
        );

  // @override
  // Future<HttpLoaderResponse> load() async {
  //   final response = await Dio().get(
  //     url,
  //     options: Options(
  //       headers: headers,
  //     ),
  //   );
  //   return HttpLoaderResponse(body: response.data, status: response.statusCode ?? 404);
  // }

  @override
  Future<HttpLoaderResponse> load() async {
    try {
      final response = await Dio().get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      return HttpLoaderResponse(body: response.data, status: response.statusCode ?? 404);
    } catch (error, stacktrace) {
      if (verbose) print('ERROR: There was an error while loading page($url): $error\n$stacktrace');
      return HttpLoaderResponse(
        body: '',
        status: 404,
      );
    }
  }
}
