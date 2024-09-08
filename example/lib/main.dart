import 'package:flutter/material.dart';
import 'package:language_service/language_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Languages.initialize(languageFolderPath:"lib/Languages/",languageCodes: ["tr", "en"]);

  runApp(
      MaterialApp(
        locale: Languages.locale(),
        localizationsDelegates: Languages.delegates(),
        supportedLocales: Languages.supLocale(),
        home: const App(),
      )
  );
}


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.v("appTitle")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Languages.v("hi")),
            LanguageWidget(update:(){setState((){});},),
          ],
        ),
      ),
    );
  }
}
