import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_app/constants/response_func.dart';
import 'package:sport_app/views/home.dart';
import 'package:sport_app/widgets/custom_button.dart';
import 'package:sport_app/widgets/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../controllers/game_provider.dart';

class GameForm extends StatefulWidget{
  final int? index;
  final String? title;
  final String? date;
  final String? time;
  final String? maxNumPlayer;
  final String? location;
  final String? description;
  final String? imageUrl;

   const GameForm({Key? key,
    this.index,
    this.title,
    this.date,
    this.time,
    this.maxNumPlayer,
    this.location,
    this.description,
    this.imageUrl
  }) : super(key: key);

  @override
  State<GameForm> createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {

  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _dateController=TextEditingController();
  final TextEditingController _timeController=TextEditingController();
  final TextEditingController _maxPlayerController=TextEditingController();
  final TextEditingController _locationController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();

  bool emptyFields = false;

  final picker = ImagePicker();
  String? imageUrl;
  bool addImage =false;

  void onImageButtonPressed(ImageSource source)async {
    final pickedFile = await picker.pickImage(
      source: source,
    );
    setState(() {
      imageUrl = pickedFile?.path;
      addImage=true;
    });
  }

  void showMyDialog(context,) {
    showDialog(
      context:context,
      builder: (BuildContext c) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          contentPadding:const EdgeInsets.all(25),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          content: SizedBox(
              height:getHeight(context)/7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: ()async{
                      onImageButtonPressed(ImageSource.camera,);
                      Navigator.of(c).pop();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.camera_alt_outlined,color: Colors.white,),
                        const SizedBox(width: 10,),
                        Text(AppLocalizations.of(context)!.camera,
                          style: const TextStyle(
                              color: Colors.white,
                          ),)
                      ],
                    ),
                  ),
                  const Divider(color: Colors.white,),
                  GestureDetector(
                    onTap: ()async{
                      onImageButtonPressed(ImageSource.gallery,);
                      Navigator.of(c).pop();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.image,color: Colors.white,),
                        const SizedBox(width: 10,),
                        Text(AppLocalizations.of(context)!.gallery,
                          style:const TextStyle(
                              color: Colors.white,
                          ),)
                      ],
                    ),
                  ),
                ],
              )
          ),
        );
      },
    );
  }

  void showConfirmDialog(context) {
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
                height: getHeight(context)/9,
                child: Center(
                  child: Text(AppLocalizations.of(context)!.confirmDelete,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: getWidth(context)/25,
                    ),
                  ),
                )
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(AppLocalizations.of(context)!.delete,
                    style:const TextStyle(color: Colors.black54,
                      fontWeight: FontWeight.bold),),
                  onPressed: () {
                    Navigator.of(c).pop();
                    _deleteFunction();
                  }
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel,
                  style:const TextStyle(color: Colors.black54,
                    fontWeight: FontWeight.bold),),
                onPressed: () {
                  Navigator.of(c).pop();
                },
              ),
            ],
          );
        });
  }

  _pickDate()async{
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat("yyyy-MM-dd").format(selectedDate);
      });
    }
  }

  _pickTime()async{
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      final text =  selectedTime.format(context);
      setState(() {
        _timeController.text = text;
      });
    }
  }

  _addFunction(){
    if(_titleController.text==''||_maxPlayerController.text==''||_dateController.text==''){
      setState(() {
        emptyFields=true;
      });
    }
    else {
      Provider.of<GameProvider>(context, listen: false).addGame(
          _titleController.text,
          _dateController.text,
          _maxPlayerController.text,
          time:_timeController.text,
          location: _locationController.text,
          description: _descriptionController.text,
          imageUrl: imageUrl
      );
      Navigator.push(context, MaterialPageRoute(builder:(context)=>const MyHomePage()));
    }
  }

  _editFunction(){
    Provider.of<GameProvider>(context, listen: false).editGame(
       widget.index,
       title:_titleController.text,
       date: _dateController.text,
       time: _timeController.text,
       maxNumPlayer: _maxPlayerController.text,
       description: _descriptionController.text,
       location: _locationController.text,
       imageUrl: imageUrl
    );
    Navigator.push(context, MaterialPageRoute(builder:(context)=>const MyHomePage()));
  }

  _deleteFunction(){
    Provider.of<GameProvider>(context, listen: false).deleteGame(widget.index);
    Navigator.push(context, MaterialPageRoute(builder:(context)=>const MyHomePage()));
  }

  @override
  void dispose(){
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _maxPlayerController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),
      body: Container(
        height: getHeight(context),
        padding: const EdgeInsets.only(top: 65,left: 20,right: 20),
        decoration:const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/img.jpg'),
              fit: BoxFit.cover,
              opacity: 0.3
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.gameInfo,
                style: TextStyle(
                    fontSize:(AppLocalizations.of(context)!.localeName=='en')? getWidth(context)/10:getWidth(context)/15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                AppLocalizations.of(context)!.fillInfo,
                style: TextStyle(
                    fontSize: getWidth(context)/21,
                    color: Colors.black,
                ),
              ),
              SizedBox(height: getHeight(context)/25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: getHeight(context)/12,
                    width: getWidth(context)/1.7,
                    child: CustomTextField(
                        controller: _titleController,
                        hintText:(widget.title==null)
                            ?AppLocalizations.of(context)!.title
                            :widget.title!,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context)/12,
                    width: getWidth(context)/3.5,
                    child: CustomTextField(
                      controller: _maxPlayerController,
                      hintText:(widget.title==null)
                          ?AppLocalizations.of(context)!.maxNumPlayers
                          :widget.maxNumPlayer!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3,),
              Row(
              children: [
               SizedBox(
                 height: getHeight(context)/12,
                 width: getWidth(context)/2.5,
                 child: TextField(
                  controller: _dateController,
                  readOnly: true,
                  decoration:InputDecoration(
                    labelText: (widget.date==null)
                        ?AppLocalizations.of(context)!.gameDate
                        :widget.date!,
                    icon: const Icon(Icons.event),
                    hintText: 'Date',
                  ),
                  onTap: _pickDate,
                 ),
               ),
               SizedBox(
                 height: getHeight(context)/12,
                 width: getWidth(context)/2.5,
                 child: TextField(
                   controller: _timeController,
                   readOnly: true,
                   decoration: InputDecoration(
                     labelText: (widget.time==null||widget.time=='')
                         ?AppLocalizations.of(context)!.gameTime
                         :widget.time!,
                     icon: const Icon(Icons.watch_later_outlined),
                     hintText: "Time",
                   ),
                   onTap: _pickTime,
                 ),
               ),
             ],
           ),
              const SizedBox(height: 9,),
              SizedBox(
                height: getHeight(context)/12,
                child: CustomTextField(
                  controller: _locationController,
                  hintText:(widget.location==null||widget.location=='')
                      ?AppLocalizations.of(context)!.addLocation
                      :widget.location!,
                ),
              ),
              const SizedBox(height: 12,),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintStyle:const TextStyle(color:Colors.black54),
                  hintText:(widget.description==null||widget.description=='')
                      ?AppLocalizations.of(context)!.addDescription
                      :widget.description! ,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                        color: Colors.black,
                        width: 1
                    ),
                  ),
                  filled: true,
                  fillColor:Colors.white24 ,
                ),
              ),
              const SizedBox(height: 12,),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: getHeight(context)/5.3,
                  width: getHeight(context)/5.3,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child:widget.imageUrl == null && !addImage
                            ? const SizedBox()
                            :addImage
                              ?Image.file(File(imageUrl!), fit: BoxFit.cover)
                              :Image.file(File(widget.imageUrl!), fit: BoxFit.cover),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              showMyDialog(context);
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.transparent)
                            ),
                            child: Text(AppLocalizations.of(context)!.addImage),
                          )
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Text(
                emptyFields
                    ?AppLocalizations.of(context)!.fillEmptyFields
                    :'',
                style:const TextStyle(
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 5,),
              Align(
                  alignment: Alignment.center,
                  child: widget.index==null
                      ?CustomButton(
                      text: AppLocalizations.of(context)!.addGame,
                      function: (){_addFunction();}
                  )
                      :Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                        CustomButton(
                          text: AppLocalizations.of(context)!.edit,
                          function:(){ _editFunction();}
                      ),
                        const SizedBox(width: 7,),
                        CustomButton(
                          text: AppLocalizations.of(context)!.delete,
                          function:(){ showConfirmDialog(context);}
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),

    );
  }
}