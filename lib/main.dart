import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sport_app/views/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'controllers/game_provider.dart';
import 'l10n/l10n.dart';
import 'l10n/locale_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<GameProvider>(
          create: (BuildContext context){
            return GameProvider();
          },),
        ChangeNotifierProvider<LocaleProvider>(
          create: (BuildContext context){
            return LocaleProvider();
          },),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, provider, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sport app',
            locale: provider.locale,
            localizationsDelegates:const[
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(),
          );
        }
      ),
    );
  }
}
