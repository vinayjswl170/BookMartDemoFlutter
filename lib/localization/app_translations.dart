
import 'package:get/get.dart';
import 'package:gutendex_books_app/localization/en_US.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS, // English (United States)
        // Add other languages here, e.g., 'fr_FR': frFR,
      };
}
