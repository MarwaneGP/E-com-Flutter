import 'package:flutter/foundation.dart';

class PwaInstallService {
  static final ValueNotifier<bool> installAvailable =
      ValueNotifier<bool>(false);

  static void init() {}

  static Future<bool> promptInstall() async => false;
}
