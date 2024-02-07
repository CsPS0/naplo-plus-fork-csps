import 'package:filcnaplo/theme/colors/colors.dart';
import 'package:refilc_plus/providers/premium_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ActivationDashboard extends StatefulWidget {
  const ActivationDashboard({super.key});

  @override
  State<ActivationDashboard> createState() => _ActivationDashboardState();
}

class _ActivationDashboardState extends State<ActivationDashboard> {
  bool manualActivationLoading = false;

  Future<void> onManualActivation() async {
    final data = await Clipboard.getData("text/plain");
    if (data == null || data.text == null || data.text == "") {
      return;
    }
    setState(() {
      manualActivationLoading = true;
    });
    final result =
        await context.read<PremiumProvider>().auth.finishAuth(data.text!);
    setState(() {
      manualActivationLoading = false;
    });

    if (!result && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Sikertelen aktiválás. Kérlek próbáld újra később!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Center(
            child: SvgPicture.asset(
              "assets/images/github.svg",
              height: 64.0,
            ),
          ),
          const SizedBox(height: 32.0),
          const Text(
            "Jelentkezz be a Gitbub felületén és adj hozzáférést a reFilc-nek, hogy aktiváld a reFilc+ szinted.",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          ),
          const SizedBox(height: 12.0),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(FeatherIcons.alertTriangle,
                          size: 20.0, color: Colors.orange),
                      SizedBox(width: 12.0),
                      Text(
                        "Figyelem!",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    "Csak akkor érzékeli a reFilc a támogatói státuszod, ha Github-on nem állítod privátra!",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(FeatherIcons.alertTriangle,
                          size: 20.0, color: Colors.orange),
                      SizedBox(width: 12.0),
                      Text(
                        "Figyelem!",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    "Az aktiválás azonnal történik, ha már támogató vagy, viszont ha még nem, előbb nyomj a neked tetsző szintre, majd fizesd ki Github-on és utána kapcsold össze a fiókod!",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ha bejelentkezés után a Github nem irányít vissza az alkalmazásba automatikusan, aktiválhatod a támogatásod a hitelesítő token-nel.",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6.0),
                  Center(
                    child: TextButton.icon(
                      onPressed: onManualActivation,
                      style: ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.secondary),
                        overlayColor: MaterialStatePropertyAll(Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(.1)),
                      ),
                      icon: manualActivationLoading
                          ? const SizedBox(
                              child: CircularProgressIndicator(),
                              height: 16.0,
                              width: 16.0,
                            )
                          : const Icon(FeatherIcons.key, size: 20.0),
                      label: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Aktiválás tokennel",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStatePropertyAll(AppColors.of(context).text),
                  overlayColor: MaterialStatePropertyAll(
                      AppColors.of(context).text.withOpacity(.1)),
                ),
                icon: const Icon(FeatherIcons.arrowLeft, size: 20.0),
                label: const Text(
                  "Vissza",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
