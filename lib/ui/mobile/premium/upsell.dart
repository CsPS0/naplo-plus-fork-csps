import 'package:filcnaplo/icons/filc_icons.dart';
import 'package:filcnaplo_mobile_ui/premium/plus_screen.dart';
import 'package:flutter/material.dart';

enum PremiumFeature {
  // old things
  gradestats,
  customcolors,
  profile,
  iconpack,
  subjectrename,
  weeklytimetable,
  widget,
  // new things
  moreAccounts, // cap, (ink, sponge)
  betaReleases, // cap
  welcomeMessage, // cap
  selfNotes, // cap
  gradeCalculation, // ink
  liveActivity, // ink
  timetableNotes, // ink
  iconChange, // sponge
  fontChange, // sponge
  goalPlanner, // sponge
}

enum PremiumFeatureLevel {
  old,
  cap,
  ink,
  sponge,
}

const Map<PremiumFeature, PremiumFeatureLevel> _featureLevels = {
  // old things
  PremiumFeature.gradestats: PremiumFeatureLevel.old,
  PremiumFeature.customcolors: PremiumFeatureLevel.old,
  PremiumFeature.profile: PremiumFeatureLevel.old,
  PremiumFeature.iconpack: PremiumFeatureLevel.old,
  PremiumFeature.subjectrename: PremiumFeatureLevel.old,
  PremiumFeature.weeklytimetable: PremiumFeatureLevel.old,
  PremiumFeature.widget: PremiumFeatureLevel.old,
  // new things
  PremiumFeature.moreAccounts: PremiumFeatureLevel.cap,
  PremiumFeature.betaReleases: PremiumFeatureLevel.cap,
  PremiumFeature.welcomeMessage: PremiumFeatureLevel.cap,
  PremiumFeature.selfNotes: PremiumFeatureLevel.cap,
  PremiumFeature.gradeCalculation: PremiumFeatureLevel.ink,
  PremiumFeature.liveActivity: PremiumFeatureLevel.ink,
  PremiumFeature.timetableNotes: PremiumFeatureLevel.ink,
  PremiumFeature.iconChange: PremiumFeatureLevel.sponge,
  PremiumFeature.fontChange: PremiumFeatureLevel.sponge,
  PremiumFeature.goalPlanner: PremiumFeatureLevel.sponge,
};

const Map<PremiumFeature, String> _featureAssets = {
  // old
  PremiumFeature.gradestats: "assets/images/premium_stats_showcase.png",
  PremiumFeature.customcolors: "assets/images/premium_theme_showcase.png",
  PremiumFeature.profile: "assets/images/premium_nickname_showcase.png",
  PremiumFeature.weeklytimetable:
      "assets/images/premium_timetable_showcase.png",
  // PremiumFeature.goalplanner: "assets/images/premium_goal_showcase.png",
  PremiumFeature.widget: "assets/images/premium_widget_showcase.png",
  // new
  PremiumFeature.moreAccounts: "assets/images/premium_banner/more_accounts.png",
  PremiumFeature.betaReleases: "assets/images/premium_banner/beta_releases.png",
  PremiumFeature.welcomeMessage:
      "assets/images/premium_banner/welcome_message.png",
  PremiumFeature.selfNotes: "assets/images/premium_banner/self_notes.png",
  PremiumFeature.gradeCalculation:
      "assets/images/premium_banner/grade_calc.png",
  PremiumFeature.liveActivity: "assets/images/premium_banner/live_activity.png",
  PremiumFeature.timetableNotes:
      "assets/images/premium_banner/timetable_notes.png",
  PremiumFeature.iconChange: "assets/images/premium_banner/app_icon.png",
  PremiumFeature.fontChange: "assets/images/premium_banner/font.png",
  PremiumFeature.goalPlanner: "assets/images/premium_banner/goal_planner.png",
};

const Map<PremiumFeature, String> _featureTitles = {
  // old shit
  PremiumFeature.gradestats: "Találtál egy prémium funkciót.",
  PremiumFeature.customcolors: "Több személyre szabás kell?",
  PremiumFeature.profile: "Nem tetszik a neved?",
  PremiumFeature.iconpack: "Jobban tetszettek a régi ikonok?",
  PremiumFeature.subjectrename:
      "Sokáig tart elolvasni, hogy \"Földrajz természettudomány\"?",
  PremiumFeature.weeklytimetable: "Szeretnéd egyszerre az egész hetet látni?",
  // PremiumFeature.goalplanner: "Kövesd a céljaidat, sok-sok statisztikával.",
  PremiumFeature.widget: "Órák a kezdőképernyőd kényelméből.",
  // new shit
  PremiumFeature.moreAccounts: "Több fiókot használnál?",
  PremiumFeature.betaReleases: "Előre kipróbálnád a frissítéseket?",
  PremiumFeature.welcomeMessage: "\"Szia cica, van gazdád?\"",
  PremiumFeature.selfNotes: "Felírnád a feladataid?",
  PremiumFeature.gradeCalculation: "Lusta vagy matekozni?",
  PremiumFeature.liveActivity: "Tudom, nem túl szép a sima szürke :P",
  PremiumFeature.timetableNotes:
      "\"Mit is csináltunk órán? Volt angol házi??\"",
  PremiumFeature.iconChange: "Ez aztán különleges!",
  PremiumFeature.fontChange: "Woah! Micsoda gyönyörű betűk!",
  PremiumFeature.goalPlanner: "Még több javaslat kell?",
};

const Map<PremiumFeature, String> _featureDescriptions = {
  // old
  PremiumFeature.gradestats:
      "Támogass Kupak szinten, hogy több statisztikát láthass. ",
  PremiumFeature.customcolors:
      "Támogass Kupak szinten, és szabd személyre az elemek, a háttér, és a panelek színeit.",
  PremiumFeature.profile:
      "Kupak szinten változtathatod a nevedet, sőt, akár a profilképedet is.",
  PremiumFeature.iconpack:
      "Támogass Kupak szinten, hogy ikon témát választhass.",
  PremiumFeature.subjectrename:
      "Támogass Kupak szinten, hogy átnevezhesd Föcire.",
  PremiumFeature.weeklytimetable:
      "Támogass Tinta szinten a heti órarend funkcióért.",
  // PremiumFeature.goalplanner: "A célkövetéshez támogass Tinta szinten.",
  PremiumFeature.widget:
      "Támogass Tinta szinten, és helyezz egy widgetet a kezdőképernyődre.",
  // new
  PremiumFeature.moreAccounts:
      "Minden támogatási szinttel egyre magasabb a limit.",
  PremiumFeature.betaReleases:
      "Támogass Kupak szinten, hogy előre megkapd a béta frissítéseket.",
  PremiumFeature.welcomeMessage:
      "Az egyedi üdvözléshez elég csupán a Kupak szint!",
  PremiumFeature.selfNotes:
      "Támogass Kupak szinten, és jegyezd fel minden fontos dolgod.",
  PremiumFeature.gradeCalculation:
      "Tinta szinttől egyszerűbb kiszámolnod a tervezett átlagod.",
  PremiumFeature.liveActivity:
      "Tinta szintű támogatással átszínezhetsz bármilyenre.",
  PremiumFeature.timetableNotes:
      "Nincs több ilyen kérdés, ha Tinta szinten támogatsz.",
  PremiumFeature.iconChange:
      "Támogass Szivacs szinten az alkalmazás ikonjának megváltoztatásához.",
  PremiumFeature.fontChange:
      "Szivacs szintű támogatással megváltoztathatod a betűtípust is.",
  PremiumFeature.goalPlanner:
      "Támogass Szivacs szinten és használd ki a cél kitűzés minden funkcióját!",
};

class PremiumLockedFeatureUpsell extends StatelessWidget {
  const PremiumLockedFeatureUpsell({super.key, required this.feature});

  static void show(
          {required BuildContext context, required PremiumFeature feature}) =>
      showDialog(
          context: context,
          builder: (context) => PremiumLockedFeatureUpsell(feature: feature));

  final PremiumFeature feature;

  IconData _getIcon() => _featureLevels[feature] == PremiumFeatureLevel.cap
      ? FilcIcons.kupak
      : _featureLevels[feature] == PremiumFeatureLevel.ink
          ? FilcIcons.tinta
          : FilcIcons.tinta;
  Color _getColor(BuildContext context) =>
      _featureLevels[feature] == PremiumFeatureLevel.cap
          ? const Color(0xffC8A708)
          : Theme.of(context).brightness == Brightness.light
              ? const Color(0xff691A9B)
              : const Color(0xffA66FC8);
  String? _getAsset() => _featureAssets[feature];
  String _getTitle() => _featureTitles[feature]!;
  String _getDescription() => _featureDescriptions[feature]!;

  @override
  Widget build(BuildContext context) {
    final Color color = _getColor(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(_getIcon()),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            // Image showcase
            if (_getAsset() != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset(_getAsset()!),
              ),

            // Dialog title
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                _getTitle(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),

            // Dialog description
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _getDescription(),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),

            // CTA button
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(color.withOpacity(.25)),
                      foregroundColor: MaterialStatePropertyAll(color),
                      overlayColor:
                          MaterialStatePropertyAll(color.withOpacity(.1))),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(builder: (context) {
                      return const PlusScreen();
                    }));
                  },
                  child: const Text(
                    "Vigyél oda!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
