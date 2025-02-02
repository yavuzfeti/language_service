library language_service;

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const FlutterSecureStorage storage = FlutterSecureStorage();

class Languages
{
  static int code = 0;
  static String path = "";
  static List<String> codes = [];
  static Map<String,dynamic> DEF = {};

  static String v (String word) => (DEF[word] ?? word).toString();

  static Future<void> initialize({required String languageFolderPath, required List<String> languageCodes}) async
  {
    path = languageFolderPath;
    codes = languageCodes;
    String? localCode = await storage.read(key: "languageCode");
    if(localCode != null && localCode != "")
    {
      await changeLanguage(int.parse(localCode));
    }
    else if (window.locales.isNotEmpty && languageCodes.contains(window.locales.first.languageCode))
    {
      await changeLanguage(languageCodes.indexOf(window.locales.first.languageCode.toString()));
    }
    else
    {
      await changeLanguage(languageCodes.indexOf("en"));
    }
  }

  static Future<void> changeLanguage(int value) async
  {
    code = value;
    DEF = await jsonDecode(await rootBundle.loadString("${path+codes[value]}.json"));
    await storage.write(key:"languageCode",value: value.toString());
    await storage.write(key:"language",value: codes[value].toUpperCase());
  }

  static List<Locale> supLocale()
  {
    List<Locale> supLcl = [];
    for(String x in codes)
    {
      supLcl.add(Locale(x));
    }
    return supLcl;
  }

  static List<LocalizationsDelegate> delegates() => [GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate, GlobalWidgetsLocalizations.delegate,];

  static Locale locale() => Locale(codes[code]);
}

class LanguageWidget extends StatefulWidget
{
  final VoidCallback update;
  const LanguageWidget({super.key, required this.update});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget>
{
  @override
  void initState(){
    super.initState();
    takeLanguageData();
  }

  bool loading = true;
  List<String> languageLabels = [];

  Future<void> takeLanguageData() async
  {
    languageLabels = [];
    for(String lanCode in Languages.codes)
    {
      languageLabels.add(await jsonDecode((await rootBundle.loadString("${Languages.path+lanCode}.json")))["languageLabel"]);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator(),)
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Languages.v("language"),
        ),
        const SizedBox(
          width: 20,
        ),
        DropdownButton<String>(
          value: languageLabels[Languages.code],
          onChanged: (value) async
          {
            setState(() {
              Languages.changeLanguage(languageLabels.indexOf(value!));
              widget.update.call();
            });
          },
          items: languageLabels.map((item)
          {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ],
    );
  }
}
