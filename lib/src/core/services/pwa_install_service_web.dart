import 'dart:html' as html;
import 'dart:js_util' as js_util;

import 'package:flutter/foundation.dart';

class PwaInstallService {
  static final ValueNotifier<bool> installAvailable =
      ValueNotifier<bool>(false);

  static dynamic _deferredPrompt;

  static void init() {
    installAvailable.value = true;
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
    await js_util.promiseToFuture(js_util.callMethod(prompt, 'prompt', []));
    _deferredPrompt = null;
    return true;
  }
}
