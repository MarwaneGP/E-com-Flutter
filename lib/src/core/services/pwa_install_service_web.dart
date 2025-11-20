// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;

import 'package:flutter/foundation.dart';

class PwaInstallService {
  static final ValueNotifier<bool> installAvailable =
      ValueNotifier<bool>(true);

  static dynamic _deferredPrompt;
  static bool _initialized = false;

  static void init() {
    if (_initialized) return;
    _initialized = true;

    html.window.addEventListener('beforeinstallprompt', (event) {
      event.preventDefault();
      _deferredPrompt = event;
      installAvailable.value = true;
    });
  }

  static Future<bool> promptInstall() async {
    final prompt = _deferredPrompt;
    if (prompt == null) return false;
    installAvailable.value = false;
    _deferredPrompt = null;

    try {
      await (prompt as dynamic).prompt();
    } catch (_) {
      return false;
    }
    return true;
  }
}
