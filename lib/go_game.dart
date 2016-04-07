library go_game;

import 'dart:html';
import 'dart:math';
import 'package:react/react_client.dart' as reactClient;
import 'package:react/react.dart' as React;

import 'package:w_flux/w_flux.dart';
import 'package:w_module/w_module.dart';

export 'go_game.dart';

part 'src/board.dart';
part 'src/dot.dart';
part 'src/actions.dart';
part 'src/store.dart';
part 'src/components.dart';
part 'src/payloads.dart';
part 'src/events.dart';

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
