part of go_game;

class GoComponents extends ModuleComponents {
  GoActions _actions;
  GoStore _store;

  GoComponents(this._actions, this._store);

  content() => BoardSvg({'actions': _actions, 'store': _store});
}

class ScoreComponents extends ModuleComponents {
  ScoreActions _actions;
  ScoreStore _store;

  ScoreComponents(this._actions, this._store);

  content() => Score({'actions': _actions, 'store': _store});
}
