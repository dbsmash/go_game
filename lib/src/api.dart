part of go_game;

class ScoreApi {

  ScoreActions _actions;
  ScoreStore _store;

  ScoreApi(this._actions, this._store);

  requestCaptureUpdate(UpdateCapturePayload payload) {
    _actions.requestCaptureRecord(payload);
  }
}