part of go_game;

class PlayPiecePayload {
  int x;
  int y;

  PlayPiecePayload(this.x, this.y);
}

class BoardUpdatedPayload {
  List<List> board;

  PlayPiecePayload(this.board);
}
