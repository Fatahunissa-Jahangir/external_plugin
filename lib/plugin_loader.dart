// lib/plugin_loader.dart
import 'dart:convert';
import 'package:external_plugin/plugin_registry.dart';
import 'package:flutter/services.dart';
import 'package:reflectable/reflectable.dart';
import 'package:extern_plugin_loader/extern_plugin_loader.dart';

class PluginLoader {
  static Future<void> loadPlugins() async {

    PluginRegistry.clearPlugins();
   // PluginRegistry().populatePluginClasses();
    final String response = await rootBundle.loadString('assets/plugin.json');
    final List<dynamic> data = json.decode(response);

     for (var pluginConfig in data) {
      String className = pluginConfig['class'];
      print(className);
      BasePlugin? plugin = createPluginInstance(className);
      if (plugin != null) {
        PluginRegistry.registerPlugin(className, () => plugin);
        print("$className, $plugin");
      } else {
        print('Error loading plugin: $className');
      }
    }
  }


  
 static BasePlugin? createPluginInstance(String className) {
      try {
      // Use reflection to find the class by name
     ClassMirror? classMirror;
      try {
        classMirror = reflector.annotatedClasses.firstWhere(
        (classMirror) => classMirror.simpleName == className,
      );
      
      } catch (e) {
        classMirror = null;
        print("createPluginInstance $e");
      }

      if (classMirror != null) {
        // Create an instance of the plugin using the class mirror
        final pluginInstance = classMirror.newInstance('', []) as BasePlugin;
        // Return the created instance directly
        return pluginInstance;
      } else {
        print('Class not found: $className');
        return null;
      }
    } catch (e) {
      print('Error creating instance of plugin: $className, $e');
      return null;
    }
  }


}
