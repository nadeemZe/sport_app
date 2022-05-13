


class GameModel{
   String? title;
   String? description;
   String? date;
   String? time;
   String? maxNumPlayer ;
   String? location;
   String? imageUrl;

  GameModel({
    required this.title,
    this.description ,
    required this.date,
    required this.maxNumPlayer,
    this.time,
    this.location,
    this.imageUrl,
  });

}