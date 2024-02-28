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
import 'package:uni_links/uni_links.dart';
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

  initAuth() {
    try {
      _sub ??= uriLinkStream.listen(
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

      launchUrl(
        Uri.parse("${FilcAPI.payment}/stripe-create-checkout?product=asdasd"),
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

  Future<bool> refreshAuth({bool removePremium = false}) async {
    if (!removePremium) {
      if (_settings.premiumAccessToken == "") {
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
            print(_settings.premiumAccessToken);
          }

          final res = await http.post(Uri.parse(FilcAPI.plusActivation), body: {
            "access_token": _settings.premiumAccessToken,
          });

          if (kDebugMode) print(res.body);

          if (res.body == "") throw "empty body";
          if (res.body == "Unauthorized") {
            throw "User is not autchenticated to Github!";
          }
          if (res.body == "empty_sponsors") {
            throw "This user isn't sponsoring anyone currently!";
          }

          final premium = PremiumResult.fromJson(jsonDecode(res.body) as Map);

          // successful activation of reFilc+
          log("[INFO] reFilc+ activated: ${premium.scopes.join(',')}");
          await _settings.update(
            premiumAccessToken: premium.accessToken,
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
        premiumAccessToken: "", premiumScopes: [], premiumLogin: "");
    return false;
  }
}
