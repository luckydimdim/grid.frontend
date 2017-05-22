import 'dart:core';
import 'package:angular2/platform/browser.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';
import 'package:alert/alert_service.dart';
import 'package:aside/aside_service.dart';
import 'package:auth/auth_service.dart';

import 'package:config/config_service.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:resources_loader/resources_loader.dart';
import 'app_component.dart';

bool get isDebug =>
    (const String.fromEnvironment('PRODUCTION', defaultValue: 'false')) !=
    'true';

main() async {
  ComponentRef ref = await bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    const Provider(ResourcesLoaderService),
    const Provider(AlertService),
    const Provider(AsideService),
    const Provider(AuthenticationService),
    const Provider(AuthorizationService),
    const Provider(ConfigService),
    provide(Client, useFactory: () => new BrowserClient(), deps: []),
  ]);

  if (isDebug) {
    print('Application in DebugMode');
    enableDebugTools(ref);
  }
}
