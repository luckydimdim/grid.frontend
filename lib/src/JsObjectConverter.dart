import 'dart:js';

@MirrorsUsed(metaTargets: "Reflectable")
import 'dart:mirrors';
import 'package:js/js_util.dart';

class Reflectable {
  const Reflectable();
}

class JsSimple {
  const JsSimple();
}

bool isJsSimple(dynamic value) {
  if (value is String || value is bool || value is int || value is double) {
    return true;
  }

  return false;
}

class JsObjectConverter {

  static JsObject convert(Object obj) {
    if (isJsSimple(obj))
      return obj;

    var result = newObject();

    var classMirror = reflectClass(reflect(obj).type.reflectedType);
    var instanceMirror = reflect(obj);

    for (var k in classMirror.declarations.keys) {
      var name = MirrorSystem.getName(k);
      var type = instanceMirror
          .getField(k)
          .type
          .reflectedType;
      var value = instanceMirror
          .getField(k)
          .reflectee; // <-- works ok



      if (value != null) {
        if (isJsSimple(value)) {
          setProperty(result, name, value);
        }
        else if (value is List) {
          var newArray = new List<Object>();

          for (var item in value) {
            newArray.add(convert(item));
          }
          setProperty(result, name, newArray);
        }
        else {
          setProperty(result, name, convert(value));
        }
      }
    }

    return result;
  }
}