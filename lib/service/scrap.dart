import 'package:web_scraper/web_scraper.dart';

class Scrap {
  static getFrases(String palavra) async {
    final frases = <String>[];

    final rawUrl =
        "https://www.pensador.com/busca.php?q=$palavra";
    final webScraper = WebScraper('https://www.pensador.com');
    final endpoint = rawUrl.replaceAll(r'https://www.pensador.com', '');
    if (await webScraper.loadWebPage(endpoint)) {
      final titleElements = webScraper.getElement(
          'p.frase',
          []);
      print(titleElements);
      titleElements.forEach((element) {
        final frase = element['title'];
        frases.add('$frase');
      });
    } else {
      print('Cannot load url');
    }

    return frases;
  }

  static getFrase(String palavra) async {
    var frases = await getFrases(palavra);
    String frase = 'Desculpe, não consigo aprender nada com essa ação.';
    if (frases.length > 0) {
      frase = frases.first;
    }

    return frase;
  }
}