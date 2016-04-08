import 'dart:html';
import 'package:react/react_client.dart' as reactClient;
import 'package:react/react.dart';

import 'package:go/go_game.dart';

main() async {
  GoModule gameModule = new GoModule();
  await gameModule.load();

  ScoreModule scoreModule = new ScoreModule();
  await scoreModule.load();

  gameModule.events.newCapturesReported.listen((payload){
    scoreModule.api.requestCaptureUpdate(payload);
  });

  reactClient.setClientConfiguration();
  render(gameModule.components.content(), querySelector('.content'));

  render(scoreModule.components.content(), querySelector('.scoreBoard'));
}
