import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_app/constants/response_func.dart';
import 'package:sport_app/constants/twilio_info.dart';
import 'package:sport_app/controllers/game_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sport_app/views/game_form.dart';
import 'package:sport_app/widgets/custom_button.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class GameWidget extends StatefulWidget{
    const GameWidget({Key? key,}) : super(key: key);

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {

  final TextEditingController _phoneNumberController= TextEditingController();
  final ScrollController scrollController = ScrollController();

  TwilioFlutter twilioFlutter =TwilioFlutter(
  accountSid : accountSid,
  authToken : authToken,
  twilioNumber : twilioNumber
  );

  void showNumberDialog(context,) {
    showDialog(
        context:context,
        builder: (BuildContext c) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(25),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)),
            content: SizedBox(
                height: getHeight(context)/7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.writeNumber,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize:  getWidth(context)/20,
                      ),
                    ),
                    const SizedBox(height: 12,),
                    SizedBox(
                      height: getHeight(context)/15,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.black54),
                            hintText: AppLocalizations.of(context)!.phone,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.phone, color: Colors.black,)
                        ),
                      ),
                    ),
                  ],
                )
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(AppLocalizations.of(context)!.send,
                    style: const TextStyle(color: Colors.black54,
                      fontWeight: FontWeight.bold),),
                  onPressed: () {
                    Navigator.of(c).pop();
                  }
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel,
                  style:const TextStyle(color: Colors.black54,
                    fontWeight: FontWeight.bold),),
                onPressed: () {
                  Navigator.of(c).pop();
                  setState(() {
                    _phoneNumberController.clear();
                  });
                },
              ),
            ],
          );
        });
   }

 /* void pagination() {
    if ((scrollController.position.pixels ==
        scrollController.position.maxScrollExtent)) {
      /*setState(() {
        //isLoading = true;
        //page += 1;
        //add api for load the more data according to new page
      });*/
    }
  }*/

  _editFunction(index,context){
    Navigator.push(context, MaterialPageRoute(builder:(context)=>
        GameForm(
          index: index,
          title:  GameProvider.userGames[index].title,
          date:  GameProvider.userGames[index].date,
          maxNumPlayer:  GameProvider.userGames[index].maxNumPlayer,
          time:  GameProvider.userGames[index].time,
          description:  GameProvider.userGames[index].description,
          location:  GameProvider.userGames[index].location,
          imageUrl:  GameProvider.userGames[index].imageUrl,
        )));
  }

  _inviteFunction(index,context){
    showNumberDialog(context);
    if(_phoneNumberController.text!=''){
      twilioFlutter.sendWhatsApp(toNumber : _phoneNumberController.text,
          messageBody :' ${GameProvider.userGames[index].title} ${GameProvider.userGames[index].date}' ).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(
                AppLocalizations.of(context)!.invitationSent),)
        );
        _phoneNumberController.text='';
      }
      );}
  }

  @override
  void initState() {
    super.initState();
    //scrollController.addListener(pagination);
  }

  @override
  void dispose(){
    _phoneNumberController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context,gameProvider,_) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            padding: const EdgeInsets.only(top: 99),
            decoration:const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/img.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.3
              ),
            ),
            child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: GameProvider.userGames.length,
                itemBuilder: (context,index){
                  return Container(
                    margin: const EdgeInsets.all(7),
                    padding: const EdgeInsets.all(5),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                    child: Row(
                      children:[
                        SizedBox(
                          height: getHeight(context)/4,
                          width:getHeight(context)/8,
                          child:GameProvider.userGames[index].imageUrl==null
                           ?const Center(child: Text('No Pic'),)
                           :Image.file(File(GameProvider.userGames[index].imageUrl),fit: BoxFit.cover,),
                        ),
                        const SizedBox(width: 5,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              GameProvider.userGames[index].title,
                              style: TextStyle(
                                  fontSize: getWidth(context)/15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  GameProvider.userGames[index].date,
                                  style: TextStyle(
                                    fontSize: getWidth(context)/35,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 3,),
                                Text(
                                  GameProvider.userGames[index].time??'',
                                  style: TextStyle(
                                    fontSize:  getWidth(context)/30,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.maxNumPlayers,
                                  style:  TextStyle(
                                    fontSize:  getWidth(context)/27,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  GameProvider.userGames[index].maxNumPlayer,
                                  style: TextStyle(
                                    fontSize:  getWidth(context)/27,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.location,
                                  style: TextStyle(
                                      fontSize:  getWidth(context)/27,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  GameProvider.userGames[index].location??'...',
                                  style: TextStyle(
                                    fontSize:  getWidth(context)/27,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width:  getWidth(context)/1.9,
                              child: Text(
                                GameProvider.userGames[index].description??'',
                                style: TextStyle(
                                  fontSize:  getWidth(context)/27,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12,),
                            Row(
                              children: [
                                CustomButton(
                                  text: AppLocalizations.of(context)!.edit,
                                  function:(){_editFunction(index,context);},
                                ),
                                const SizedBox(width: 7,),
                                CustomButton(
                                  text: AppLocalizations.of(context)!.invite,
                                    function:(){_inviteFunction(index,context);}
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }
            ),
          ),
        );
      }
    );
  }
}