import 'package:bitflow_web/getx/status_get.dart';
import 'package:bitflow_web/getx/store_get.dart';
import 'package:bitflow_web/getx/theme_get.dart';
import 'package:bitflow_web/desktop/main_window.dart';
import 'package:bitflow_web/lang/en_us.dart';
import 'package:bitflow_web/lang/zh_cn.dart';
import 'package:bitflow_web/lang/zh_tw.dart';
import 'package:bitflow_web/lang/ja_jp.dart';
import 'package:bitflow_web/lang/ko_kr.dart';
import 'package:bitflow_web/lang/de_de.dart';
import 'package:bitflow_web/lang/ru_ru.dart';
import 'package:bitflow_web/lang/es_es.dart';
import 'package:bitflow_web/lang/pt_br.dart';
import 'package:bitflow_web/lang/fr_fr.dart';
import 'package:bitflow_web/mobile/main_view.dart';
import 'package:bitflow_web/service/aria.dart';
import 'package:bitflow_web/service/funcs.dart';
import 'package:bitflow_web/service/qbit.dart';
import 'package:bitflow_web/service/trans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final theme=Get.put(ThemeGet());
  final status=Get.put(StatusGet());
  Get.put(TransmissionService());
  Get.put(AriaService());
  Get.put(QbitService());
  final store=Get.put(StoreGet());
  await store.init();
  Get.put(FuncsService());
  await status.initLang();
  await theme.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class MainTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'zh_CN': zhCN,
    'zh_TW': zhTW,
    'ja_JP': jaJP,
    'ko_KR': koKR,
    'de_DE': deDE,
    'ru_RU': ruRU,
    'es_ES': esES,
    'pt_BR': ptBR,
    'fr_FR': frFR,
  };
}

class _MainAppState extends State<MainApp> {
  final ThemeGet themeGet=Get.find();
  final StatusGet statusGet=Get.find();

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    themeGet.darkModeHandler(brightness==Brightness.dark);
    final width = MediaQuery.of(context).size.width;

    return Obx(
      ()=> GetMaterialApp(
        translations: MainTranslations(), 
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        locale: statusGet.lang.value.locale, 
        supportedLocales: supportedLocales.map((item)=>item.locale).toList(),
        theme: ThemeData(
          brightness: themeGet.darkMode.value ? Brightness.dark : Brightness.light,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange,
            brightness: themeGet.darkMode.value ? Brightness.dark : Brightness.light,
          ),
          textTheme: themeGet.darkMode.value ? ThemeData.dark().textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ) : ThemeData.light().textTheme.apply(),
          listTileTheme: Theme.of(context).listTileTheme.copyWith(
            mouseCursor: WidgetStateProperty.all(SystemMouseCursors.basic),
          ),
        ),
        home: width > 600 ?  MainWindow() : MainView()
      ),
    );
  }
}
