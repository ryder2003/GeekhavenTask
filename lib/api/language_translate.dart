import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  final String apiKey = '929e06ed4amshab4fc46b9ec218fp164686jsn81f628d5d30c';

  Future<String> translateText(String text, String targetLanguage) async {
    final url = Uri.parse(
        'https://translation.googleapis.com/language/translate/v2?target=$targetLanguage&q=$text&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['data']['translations'][0]['translatedText'];
    } else {
      throw Exception('Failed to translate text');
    }
  }
}
