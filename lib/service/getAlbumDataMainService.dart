import 'package:http/http.dart' as http;

Future<String> getWebSiteBody(String url) async {
  final http.Response webResponse = await http.Client().get(Uri.parse(url));
  if (webResponse.statusCode == 200) {
    return webResponse.body;
  } else {
    return "";
  }
}
