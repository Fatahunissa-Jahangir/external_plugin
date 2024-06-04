import 'package:external_plugin/main.reflectable.dart';
import 'package:external_plugin/plugin_loader.dart';
import 'package:external_plugin/plugin_registry.dart';
import 'package:flutter/material.dart';

//import 'package:extern_plugin_loader/extern_plugin_loader.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    initializeReflectable();
    await PluginLoader.loadPlugins();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Plugin Loading',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dynamic Plugin Loading'),
        ),
        body: PluginRunner(),
      ),
    );
  }
}
class PluginRunner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => runPlugin('TempusPlugin', context),
            child: Text('Run Tempus Plugin'),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () => runPlugin('CustomPlugin', context),
            child: Text('Run Custom Plugin'),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () => runPlugin('UPIPlugin', context),
            child: Text('Run UPI Plugin'),
          ),
        ],
      ),
    );
  }

   runPlugin(String pluginName, context) {
    final plugin = PluginRegistry.getPlugin(pluginName);

      return showDialog(
        context: context, 
        builder: (ctx) {
          if (plugin != null) {
              print("plugin found");
              return plugin.performAction();      
            } else {
              print('Plugin not found: $pluginName');
              return  AlertDialog(
                title:  const Text("Alert Dialog Box"),
                content: Text('Plugin not found: $pluginName'),
              );
            }
        }
      );
   }
}