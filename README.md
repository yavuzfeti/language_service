# `language_service` Package

The `language_service` package is designed to provide multi-language support in Flutter applications. This package loads language files in JSON format and allows you to easily manage language changes.

## Features

- **Load Language Files**: Loads language files in JSON format.
- **Change Language**: Changes the application language and stores the user preference.
- **Supported Languages**: Lists the supported languages.
- **Dynamic Language Change**: UI updates immediately when the user changes the language.

## Installation

1. **Package Installation**

   Add the `language_service` package to your `pubspec.yaml` file:

```yaml
   dependencies:
     flutter:
       sdk: flutter
     language_service: 0.0.2
```

Configuring Language Files

Place your language files in the lib/Languages/ directory. Create a JSON file for each language. Example language file:

```json
{
   "languageCode": "en", 
   "languageLabel": "English", 
   "language": "Language", 
   "appTitle" : "Language Service Demo", 
   "hi" : "Hello"
}
```

Defining Language Files in pubspec.yaml

Add your language files to your pubspec.yaml file:

```yaml
assets:
- lib/Languages/
```

## Usage

You can use the package in your main.dart file as follows:

```dart
import 'package:flutter/material.dart';
import 'package:language_service/language_service.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Languages.initialize(languageFolderPath: "lib/Languages/", languageCodes: ["tr", "en"]);
  
  runApp(MaterialApp(
     locale: Languages.locale(), 
     localizationsDelegates: Languages.delegates(), 
     supportedLocales: Languages.supLocale(), 
     home: const App(),
  ));
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
                LanguageWidget(update:(){setState((){});}),
             ],
          ),
       ),
    );
  }
}
```

## Classes and Methods
### Languages Class
**Properties:**
    
code: Holds the index of the active language.

path: Path to the directory containing language files.

codes: Contains the codes of the supported languages.

DEF: Content of the loaded language file.

**Methods:**

v(String word): Returns the language translation corresponding to the given key.

initialize({required String languageFolderPath, required List<String> languageCodes}): Initializes by taking the path to the language files and the language codes.

changeLanguage(int value): Changes and updates the active language.

supLocale(): Returns the supported languages as a Locale list.

delegates(): Returns a list of LocalizationsDelegate.

locale(): Returns the current active Locale.

### LanguageWidget Class
**Properties:**

update: Callback function used to update the UI after a language change.

**Methods:**

takeLanguageData(): Loads language data.

build(BuildContext context): Creates the widget and includes a DropdownButton for language change.

## License

This project is licensed under the MIT License. For more information, please refer to the LICENSE file.

This README.md file clearly explains the usage, installation, and classes of the package. If you wish to add any customizations or additional information, you can update the file accordingly.