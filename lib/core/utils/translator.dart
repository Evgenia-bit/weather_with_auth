import 'package:translator/translator.dart';

class Translator {
  static Future<String> translateText(String text) async {
    final translator = GoogleTranslator();
    return (await translator.translate(text, from: 'en', to: 'ru')).text;
  }
}