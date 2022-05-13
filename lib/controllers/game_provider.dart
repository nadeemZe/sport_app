import 'package:flutter/material.dart';
import 'package:sport_app/models/game_model.dart';

class GameProvider extends ChangeNotifier{

  static List userGames=[
    GameModel(title: 'game1', date: '2022-05-12', maxNumPlayer: '10',description: 'just a text to fill space and find if it looks good',),
    GameModel(title: 'game2', date: '2022-05-17', maxNumPlayer: '10'),
    GameModel(title: 'Title3', date: '2022-05-28', maxNumPlayer: '10'),
    GameModel(title: 'game4', date: '2022-06-12', maxNumPlayer: '10', ),
    GameModel(title: 'play5', date: '2022-06-25', maxNumPlayer: '10'),
    GameModel(title: 'game6', date: '2022-07-01', maxNumPlayer: '10'),
    GameModel(title: 'game7', date: '2022-07-12', maxNumPlayer: '10'),
  ];


  addGame(title,date,maxNumPlayer,{String? description,String? time,String? location,String? imageUrl}){
    GameModel gameModel=GameModel(
          title: title,
          date: date,
          maxNumPlayer: maxNumPlayer,
          description: description,
          time: time,
          location: location,
          imageUrl: imageUrl
    );
    userGames.insert(0,gameModel);
    notifyListeners();
  }

  editGame(i,{String? title,String? date,String? time,String? maxNumPlayer,String? description,String? location,String? imageUrl}){
    if(title!=''){userGames[i].title=title;}
    if(date!=''){userGames[i].date=date;}
    if(time!=''){userGames[i].time=time;}
    if(maxNumPlayer!=''){userGames[i].maxNumPlayer=maxNumPlayer;}
    if(description!=''){userGames[i].description=description;}
    if(location!=''){userGames[i].location=location;}
    if(imageUrl!=null){userGames[i].imageUrl=imageUrl;}
    notifyListeners();
  }

  deleteGame(index){
    userGames.removeAt(index);
    notifyListeners();
  }

  sortGames(value){
    if(value=='title'){
    userGames.sort((a, b) {
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });}
    else {userGames.sort((a, b) {
      return DateTime.parse(a.date).compareTo(DateTime.parse(b.date));
    });}
    notifyListeners();
  }

}