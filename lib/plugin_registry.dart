// lib/plugin_registry.dart

import 'package:extern_plugin_loader/extern_plugin_loader.dart';

final Map<String, Type> pluginClasses = {};

 typedef PluginFactory = BasePlugin Function();


class PluginRegistry {
  static final Map<String, PluginFactory> _factories = {};

  static void registerPlugin(String name, PluginFactory factory) {
    _factories[name] = factory;
  }

  static BasePlugin? getPlugin(String name) {
    final factory = _factories[name];
    return factory != null ? factory() : null;
  }

  static void clearPlugins() {
    _factories.clear();
  }

  void populatePluginClasses() {
  for (var member in reflector.annotatedClasses) {
     print("populatePluginClasses ${reflector.annotatedClasses.length} ${member.simpleName}");
    pluginClasses[member.simpleName] = member.reflectedType;
  }
}
}
