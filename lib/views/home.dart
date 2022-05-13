import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sport_app/views/game_form.dart';
import 'package:sport_app/widgets/game_widget.dart';
import '../controllers/game_provider.dart';
import '../l10n/l10n.dart';
import '../l10n/locale_provider.dart';


class MyHomePage extends StatelessWidget{
  const MyHomePage({Key? key}) : super(key: key);

  _title(String val) {
    switch (val) {
      case 'en':
        return const Text(
          'English',
          style: TextStyle(color: Colors.white),
        );
      case 'ar':
        return const Text(
          'عربي',
          style: TextStyle(color: Colors.white),
        );
      default:
        return const Text(
          'Arabic',
          style: TextStyle(color: Colors.black),
        );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<LocaleProvider>(
        builder: (context, provider, snapshot) {
          var lang = provider.locale ?? Localizations.localeOf(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 99,
            leading:Padding(
              padding: const EdgeInsets.all(7.0),
              child: DropdownButton(
                  borderRadius: BorderRadius.circular(12),
                  dropdownColor: Colors.blueGrey,
                  icon:const Icon(Icons.language_outlined,color: Colors.black,),
                  value: lang,
                  style:const TextStyle(color: Colors.black),
                  onChanged: (Locale? val) {
                    provider.setLocale(val!);
                  },
                  items: L10n.all
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: _title(e.languageCode),
                  ))
                      .toList()),
            ),
            actions: [
              DropdownButton(
                  icon:const Icon(Icons.sort,color: Colors.black,),
                  dropdownColor: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12),
                  onChanged: (String? value) {
                    Provider.of<GameProvider>(context, listen: false).sortGames(value);
                  },
                  items:[
                    DropdownMenuItem(
                        value: 'date',
                        child:Text(AppLocalizations.of(context)!.sortDate,
                          style: const TextStyle(color: Colors.white),),
                    ),
                    DropdownMenuItem(
                      value: 'title',
                      child:Text(AppLocalizations.of(context)!.sortTitle,
                        style: const TextStyle(color: Colors.white),),
                    ),
                  ]
              ),
             IconButton(
               onPressed:(){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const GameForm()));
               },
               tooltip: 'add game',
               icon: const Icon(Icons.add,color: Colors.black,),
             ),
            ],
          ),
          body: const GameWidget(),
        );
      }
    );
  }
}