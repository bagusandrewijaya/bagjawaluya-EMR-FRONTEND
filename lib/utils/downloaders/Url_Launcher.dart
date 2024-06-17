import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> bukaBrowser(url) async {
  if (!await launchUrl(Uri.parse(url),webViewConfiguration: WebViewConfiguration(
      headers: API.credentialsMap),)) {
    throw Exception('error $url');
  }
}