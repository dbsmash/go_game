part of go_game;

class GoComponents extends ModuleComponents {
  GoActions _actions;
  GoStore _store;

  GoComponents(this._actions, this._store);

  content() => BoardSvg({'actions': _actions, 'store': _store});
}

