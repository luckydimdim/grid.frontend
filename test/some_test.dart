@TestOn('dartium')
import 'package:test/test.dart';

import 'package:angular2/angular2.dart';
import 'package:angular2/reflection.dart';

class InjectableService {
  bool someMethod() {
    return false;
  }
}

@Injectable()
class SomeComponent {
  final InjectableService _injectableService;

  SomeComponent(this._injectableService);
}

class MockInjectableService implements InjectableService {
  bool someMethod() {
    return true;
  }
}

String _tagNameFromComponentSelector(String selector) {
  int pos = selector.indexOf(':');

  print('1. pos = $pos selector = $selector');

  if (pos != -1) selector = selector.substring(0, pos);

  print('2. pos = $pos selector = $selector');

  pos = selector.indexOf('[');

  print('3. pos = $pos selector = $selector');

  if (pos != -1) selector = selector.substring(0, pos);

  print('4. pos = $pos selector = $selector');

  pos = selector.indexOf('(');

  print('5. pos = $pos selector = $selector');

  if (pos != -1) selector = selector.substring(0, pos);

  print('6. pos = $pos selector = $selector');

  // Some users have invalid space before selector in @Component, trim so
  // that document.createElement call doesn't fail.
  return selector.trim();
}

main() {
  allowRuntimeReflection();

  group('test group', () {


    setUp(() {

    });

    test('some test', () {
      print(_tagNameFromComponentSelector('123[[123]]'));
    });
  });
}
