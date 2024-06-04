// lib/reflectable_annotations.dart
import 'package:reflectable/reflectable.dart';

// final Map<String, Type> pluginClasses = {};

class Reflector extends Reflectable {
  const Reflector()
      : super(
          invokingCapability,
          typeCapability,
          subtypeQuantifyCapability,
          metadataCapability,
          declarationsCapability,
        );
}

const reflector = Reflector();


// void populatePluginClasses() {
//   for (var member in reflector.annotatedClasses) {
//     pluginClasses[member.simpleName] = member.reflectedType;
//   }
// }
