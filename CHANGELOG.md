# `language_service` Package - Changelog

## Version 2.0.0

### Major Updates
- **saveLanguage Method Removed**: The `saveLanguage` method has been removed in favor of a new, more streamlined method.
- **changeLanguage Method Added**: Introduced the `changeLanguage` method to manage language switching and saving user preferences.

### Features
- **Improved Language Management**: The new `changeLanguage` method provides a simpler interface for changing the app's language dynamically.
- **Backward Compatibility**: Ensured backward compatibility with existing language data stored in JSON format.
- **Automatic UI Update**: As in the previous version, the UI automatically updates when the language is changed.
- **Persistent Language Preferences**: User-selected languages are still saved and restored in future sessions.

### Bug Fixes
- **Performance Improvements**: Optimized the way language files are loaded and managed, resulting in faster language switching.

## Version 1.0.0

### Initial Release
- **Multi-language Support**: Added support for loading and managing multiple languages using JSON files.
- **Language Management**: Ability to change the application's language dynamically.
- **User Preference Saving**: Stores the user's selected language preference for future sessions.
- **UI Update**: Automatically updates the UI when the language changes.
- **Supported Languages**: Added support for listing the languages available in the app.

### Features
- **JSON Language Files**: Language data is loaded from JSON files stored in the app's `lib/Languages/` directory.
- **Dynamic Language Switching**: Seamless switching between different languages without needing to restart the app.
- **Localization Delegates**: Integrated localization delegates for easy language integration in Flutter.
