import 'package:flutter_test/flutter_test.dart';
import 'Package:sport_app/controllers/game_provider.dart';


main(){
  group('addGame function',()
  {
    test('addGame function with required parameters ', () {
      String title = 'gameTest';
      String mxPlayer = '5';
      String date = '2022-5-17';

      GameProvider().addGame(title, date, mxPlayer);

      expect(GameProvider.userGames[0].title, 'gameTest');
      expect(GameProvider.userGames[0].date, '2022-5-17');
      expect(GameProvider.userGames[0].maxNumPlayer, '5');
    });

    test('addGame function with optional parameters', () {
      String title = 'gameTest';
      String date = '2022-5-17';
      String maxNumPlayer = '5';
      String location = ' santiago bernabeu';

      GameProvider().addGame(title, date, maxNumPlayer, location: location);

      expect(GameProvider.userGames[0].title, 'gameTest');
      expect(GameProvider.userGames[0].date, '2022-5-17');
      expect(GameProvider.userGames[0].maxNumPlayer, '5');
      expect(GameProvider.userGames[0].location, ' santiago bernabeu');
    });
  });

  test('editGame function', () {
    int index=0;
    String title = 'gameTestEdit';
    String maxNumPlayer = '7';
    String description = 'bring snacks and water with you';

    GameProvider().editGame(index,title:title, maxNumPlayer:maxNumPlayer, description: description);

    expect(GameProvider.userGames[0].title, 'gameTestEdit');
    expect(GameProvider.userGames[0].maxNumPlayer, '7');
    expect(GameProvider.userGames[0].description, 'bring snacks and water with you');
  });


}