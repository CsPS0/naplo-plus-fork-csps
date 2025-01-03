import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:refilc/api/client.dart';
import 'package:refilc/models/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:refilc_plus/models/premium_result.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';
import 'package:http/http.dart' as http;
// import 'package:home_widget/home_widget.dart';

class PremiumAuth {
  final SettingsProvider _settings;
  StreamSubscription? _sub;

  PremiumAuth({required SettingsProvider settings}) : _settings = settings;

  // initAuth() {
  //   try {
  //     _sub ??= uriLinkStream.listen(
  //       (Uri? uri) {
  //         if (uri != null) {
  //           final accessToken = uri.queryParameters['access_token'];
  //           if (accessToken != null) {
  //             finishAuth(accessToken);
  //           }
  //         }
  //       },
  //       onError: (err) {
  //         log("ERROR: initAuth: $err");
  //       },
  //     );

  //     launchUrl(
  //       Uri.parse(FilcAPI.plusAuthLogin),
  //       mode: LaunchMode.externalApplication,
  //     );
  //   } catch (err, sta) {
  //     log("ERROR: initAuth: $err\n$sta");
  //   }
  // }

  initAuth({required String product, required String paymentProvider}) {
    try {
      final appLinks = AppLinks();
      _sub ??= appLinks.uriLinkStream.listen(
        (Uri? uri) {
          if (uri != null) {
            final sessionId = uri.queryParameters['session_id'];
            if (sessionId != null) {
              finishAuth(sessionId);
            }
          }
        },
        onError: (err) {
          log("ERROR: initAuth: $err");
        },
      );

      String url = "https://refilcapp.hu";
      if (paymentProvider == "stripe") {
        url =
            "${FilcAPI.payment}/stripe-create-checkout?product=$product&rf_uinid=${_settings.xFilcId}";
      } else if (paymentProvider == "paypal") {
        url =
            "https://refilcapp.hu/payment/paypal/mobile-checkout?product=$product&device_id=${_settings.xFilcId}";
      }

      launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } catch (err, sta) {
      log("ERROR: initAuth: $err\n$sta");
    }
  }

  // Future<bool> finishAuth(String accessToken) async {
  //   try {
  //     // final res = await http.get(Uri.parse(
  //     //     "${FilcAPI.plusScopes}?access_token=${Uri.encodeComponent(accessToken)}"));
  //     // final scopes =
  //     //     ((jsonDecode(res.body) as Map)["scopes"] as List).cast<String>();
  //     // log("[INFO] Premium auth finish: ${scopes.join(',')}");
  //     await _settings.update(premiumAccessToken: accessToken);
  //     final result = await refreshAuth();
  //     // if (Platform.isAndroid) updateWidget();
  //     return result;
  //   } catch (err, sta) {
  //     log("[ERROR] reFilc+ auth failed: $err\n$sta");
  //   }

  //   await _settings.update(premiumAccessToken: "", premiumScopes: []);
  //   // if (Platform.isAndroid) updateWidget();
  //   return false;
  // }

  Future<bool> finishAuth(String sessionId) async {
    try {
      // final res = await http.get(Uri.parse(
      //     "${FilcAPI.plusScopes}?access_token=${Uri.encodeComponent(accessToken)}"));
      // final scopes =
      //     ((jsonDecode(res.body) as Map)["scopes"] as List).cast<String>();
      // log("[INFO] Premium auth finish: ${scopes.join(',')}");
      await _settings.update(plusSessionId: sessionId);
      final result = await refreshAuth();
      // if (Platform.isAndroid) updateWidget();
      return result;
    } catch (err, sta) {
      log("[ERROR] reFilc+ auth failed: $err\n$sta");
    }

    await _settings.update(plusSessionId: "", premiumScopes: []);
    // if (Platform.isAndroid) updateWidget();
    return false;
  }

  // Future<bool?> updateWidget() async {
  //   try {
  //     return HomeWidget.updateWidget(name: 'widget_timetable.WidgetTimetable');
  //   } on PlatformException catch (exception) {
  //     if (kDebugMode) {
  //       print('Error Updating Widget After Auth. $exception');
  //     }
  //   }
  //   return false;
  // }

  Future<bool> refreshAuth(
      {bool removePremium = false, bool reactivate = false}) async {
    if (!removePremium) {
      if (_settings.plusSessionId == "" && !reactivate) {
        await _settings.update(premiumScopes: [], premiumLogin: "");
        return false;
      }

      // skip reFilc+ check when disconnected
      try {
        final status = await InternetAddress.lookup('api.refilc.hu');
        if (status.isEmpty) return false;
      } on SocketException catch (_) {
        return false;
      }

      for (int tries = 0; tries < 3; tries++) {
        try {
          if (kDebugMode) {
            print(FilcAPI.plusActivation);
            print(_settings.plusSessionId);
            print(_settings.xFilcId);
          }

          final res = await http.post(Uri.parse(FilcAPI.plusActivation), body: {
            "session_id": _settings.plusSessionId,
            "rf_uinid": _settings.xFilcId,
          });

          if (kDebugMode) print(res.body);

          if (res.body == "") throw "empty body";
          // if (res.body == "Unauthorized") {
          //   throw "User is not autchenticated to Github!";
          // }
          // if (res.body == "empty_sponsors") {
          //   throw "This user isn't sponsoring anyone currently!";
          // }
          if (res.body == "expired_subscription") {
            throw "This user isn't a subscriber anymore!";
          }
          if (res.body == "no_subscription") {
            throw "This user isn't a subscriber!";
          }
          if (res.body == "unknown_device") {
            throw "This device is not recognized, please contact support!";
          }

          final premium = PremiumResult.fromJson(jsonDecode(res.body) as Map);

          // successful activation of reFilc+
          log("[INFO] reFilc+ activated: ${premium.scopes.join(',')}");
          await _settings.update(
            plusSessionId: premium.sessionId,
            premiumScopes: premium.scopes,
            premiumLogin: premium.login,
          );
          return true;
        } catch (err, sta) {
          // error while activating reFilc+
          log("[ERROR] reFilc+ activation failed: $err\n$sta");
        }

        await Future.delayed(const Duration(seconds: 1));
      }
    }

    // activation of reFilc+ failed
    await _settings.update(
      premiumAccessToken: "",
      premiumScopes: [],
      premiumLogin: "",
      plusSessionId: "",
    );
    return false;
  }
}
