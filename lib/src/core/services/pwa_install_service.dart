import 'package:flutter/foundation.dart';

class PwaInstallService {
  static final ValueNotifier<bool> installAvailable =
      ValueNotifier<bool>(kIsWeb);

  static void init() {}

  static Future<bool> promptInstall() async => false;
}
