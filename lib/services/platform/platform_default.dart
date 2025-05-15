export 'package:flutter_5_wd/services/platform/platform_default.dart'
    if (dart.library.io) 'package:flutter_5_wd/services/platform/platform_mobile.dart'
    if (dart.library.html) 'package:flutter_5_wd/services/platform/platform_web.dart';

void setUrlStrategy() {}
