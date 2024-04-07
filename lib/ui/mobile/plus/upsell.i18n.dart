import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations.byLocale("hu_hu") +
      {
        "en_en": {
          // upsell titles
          "u_title_1": "Use more accounts?",
          "u_title_2": "Want to try the updates in advance?",
          "u_title_3": "\"Hi kitty, do you have an owner?\"",
          "u_title_4": "Would you write down your tasks?",
          "u_title_5": "Lazy to do maths?",
          "u_title_6": "I know, the plain grey is not very nice :P",
          "u_title_7":
              "\"What were we doing in class? Was there English homework??\"",
          "u_title_8": "Now that's something special!",
          "u_title_9": "Woah! What beautiful letters!",
          "u_title_10": "Need more suggestions?",
          "u_title_11": "Not epic, but ultra-super?",
          "u_title_12": "Do you even need it in your calendar?!",
          // upsell descriptions
          "u_desc_1": "The limit increases with each level.",
          "u_desc_2":
              "Subscribe to reFilc+ to receive beta updates in advance.",
          "u_desc_3": "For a unique greeting, just the lowest level is enough!",
          "u_desc_4":
              "Support us and make a note of all your important things.",
          "u_desc_5":
              "reFilc+ makes it easier to calculate your projected average.",
          "u_desc_6": "With Gold level, you can recolour to anything.",
          "u_desc_7": "No more questions in Gold.",
          "u_desc_8": "Upgrade to Gold to change the app icon.",
          "u_desc_9": "You can also change the font with Gold level.",
          "u_desc_10":
              "Support us on Gold level and use all the features of goal setting!",
          "u_desc_11": "With reFilc+ lowest level it's also available!",
          "u_desc_12": "Sync your time-table with reFilc+ Gold!",
        },
        "hu_hu": {
          // upsell titles
          "u_title_1": "Több fiókot használnál?",
          "u_title_2": "Előre kipróbálnád a frissítéseket?",
          "u_title_3": "\"Szia cica, van gazdád?\"",
          "u_title_4": "Felírnád a feladataid?",
          "u_title_5": "Lusta vagy matekozni?",
          "u_title_6": "Tudom, nem túl szép a sima szürke :P",
          "u_title_7": "\"Mit is csináltunk órán? Volt angol házi??\"",
          "u_title_8": "Ez aztán különleges!",
          "u_title_9": "Woah! Micsoda gyönyörű betűk!",
          "u_title_10": "Még több javaslat kell?",
          "u_title_11": "Nem epikus, hanem ultraszuper?",
          "u_title_12": "Még a naptáradba is kell?!",
          // upsell descriptions
          "u_desc_1": "Minden támogatási szinttel egyre magasabb a limit.",
          "u_desc_2":
              "Fizess elő reFilc+-ra, hogy előre megkapd a béta frissítéseket.",
          "u_desc_3": "Az egyedi üdvözléshez elég csupán a legalsó szint!",
          "u_desc_4": "Támogass minket, és jegyezd fel minden fontos dolgod.",
          "u_desc_5": "reFilc+-al egyszerűbb kiszámolnod a tervezett átlagod.",
          "u_desc_6": "Gold szintű támogatással átszínezhetsz bármilyenre.",
          "u_desc_7": "Nincs több ilyen kérdés, ha Gold szinten támogatsz.",
          "u_desc_8":
              "Fizess elő Gold szintre az alkalmazás ikonjának megváltoztatásához.",
          "u_desc_9":
              "Gold szintű támogatással megváltoztathatod a betűtípust is.",
          "u_desc_10":
              "Támogass Gold szinten és használd ki a cél kitűzés minden funkcióját!",
          "u_desc_11": "A reFilc+ alap szintjével ez is elérhető!",
          "u_desc_12": "Szinkronizáld az órarended reFilc+ Gold-al!",
        },
        "de_de": {
          // upsell titles
          "u_title_1": "Több fiókot használnál?",
          "u_title_2": "Előre kipróbálnád a frissítéseket?",
          "u_title_3": "\"Szia cica, van gazdád?\"",
          "u_title_4": "Felírnád a feladataid?",
          "u_title_5": "Lusta vagy matekozni?",
          "u_title_6": "Tudom, nem túl szép a sima szürke :P",
          "u_title_7": "\"Mit is csináltunk órán? Volt angol házi??\"",
          "u_title_8": "Ez aztán különleges!",
          "u_title_9": "Woah! Micsoda gyönyörű betűk!",
          "u_title_10": "Még több javaslat kell?",
          "u_title_11": "Nem epikus, hanem ultraszuper?",
          "u_title_12": "Még a naptáradba is kell?!",
          // upsell descriptions
          "u_desc_1": "Minden támogatási szinttel egyre magasabb a limit.",
          "u_desc_2":
              "Fizess elő reFilc+-ra, hogy előre megkapd a béta frissítéseket.",
          "u_desc_3": "Az egyedi üdvözléshez elég csupán a legalsó szint!",
          "u_desc_4": "Támogass minket, és jegyezd fel minden fontos dolgod.",
          "u_desc_5": "reFilc+-al egyszerűbb kiszámolnod a tervezett átlagod.",
          "u_desc_6": "Gold szintű támogatással átszínezhetsz bármilyenre.",
          "u_desc_7": "Nincs több ilyen kérdés, ha Gold szinten támogatsz.",
          "u_desc_8":
              "Fizess elő Gold szintre az alkalmazás ikonjának megváltoztatásához.",
          "u_desc_9":
              "Gold szintű támogatással megváltoztathatod a betűtípust is.",
          "u_desc_10":
              "Támogass Gold szinten és használd ki a cél kitűzés minden funkcióját!",
          "u_desc_11": "A reFilc+ alap szintjével ez is elérhető!",
          "u_desc_12": "Szinkronizáld az órarended reFilc+ Gold-al!",
        },
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
  String plural(int value) => localizePlural(value, this, _t);
  String version(Object modifier) => localizeVersion(modifier, this, _t);
}
