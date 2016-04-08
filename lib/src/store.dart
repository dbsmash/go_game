part of go_game;

class GoStore extends Store {
  GoActions _actions;
  GoEvents _events;
  GoBoard board;

  bool blackTurn = true;

  GoEvents get events => _events;

  GoStore(this._actions, this._events) {
    _actions.requestPiecePlacement.listen(_handlePieceRequest);
    board = new GoBoard(19);
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
