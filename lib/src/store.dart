part of go_game;

class GoStore extends Store {
  GoActions _actions;
  GoEvents _events;
  GoBoard board;

  bool blackTurn = true;

  GoEvents get events => _events;

  GoStore(this._actions, this._events) {
    _actions.requestPiecePlacement.listen(_handlePieceRequest);
    board = new GoBoard(19, this);
  }

  String getHoverColor() {
    if(blackTurn) {
        return 'black';
    }
    return 'white';
  }

  void _handlePieceRequest(PlayPiecePayload payload) {
    bool success = this.board.makeMove(payload.x, payload.y);
    if (!success) {
        return;
    }
    // handle illegal move
    blackTurn = !blackTurn;
    this.trigger();
  }
}

class ScoreStore extends Store {
  ScoreActions _actions;
  ScoreEvents _events;

  int blackCaptured = 0;
  int whiteCaptured = 0;

  ScoreStore(this._actions, this._events){
    _actions.requestCaptureRecord.listen(_handleCapture);
  }

  void _handleCapture(UpdateCapturePayload payload) {

    String color = payload.color;
    if (color == 'B') {
      this.blackCaptured += payload.captures;
      } else if (color == 'W') {
        this.whiteCaptured += payload.captures;
      }
    this.trigger();
  }
}
