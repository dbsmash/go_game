library go_game;

import 'dart:html' hide Event;
import 'dart:math';
import 'package:react/react_client.dart' as reactClient;
import 'package:react/react.dart' as React;

import 'package:w_flux/w_flux.dart';
import 'package:w_module/w_module.dart';

export 'go_game.dart';

part 'src/board_component.dart';
part 'src/board.dart';
part 'src/dot_component.dart';
part 'src/actions.dart';
part 'src/store.dart';
part 'src/components.dart';
part 'src/payloads.dart';
part 'src/events.dart';
part 'src/api.dart';
part 'src/score_component.dart';
part 'src/score_box_component.dart';

class GoModule extends Module {
  GoComponents _components;
  GoEvents _events;

  GoComponents get components => _components;
  GoEvents get events => _events;

  GoModule() {
    _events = new GoEvents();

    GoActions actions = new GoActions();
    GoStore store = new GoStore(actions, _events);

    _components = new GoComponents(actions, store);
  }
}

class ScoreModule extends Module {
  ScoreComponents _components;
  ScoreEvents _events;
  ScoreApi _api;

  ScoreComponents get components => _components;
  ScoreEvents get events => _events;
  ScoreApi get api => _api;

  ScoreModule() {
    _events = new ScoreEvents();

    ScoreActions actions = new ScoreActions();
    ScoreStore store = new ScoreStore(actions, _events);
    _api = new ScoreApi(actions, store);

    _components = new ScoreComponents(actions, store);
  }
}
