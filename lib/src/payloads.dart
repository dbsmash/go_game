part of go_game;

class PlayPiecePayload {
  int x;
  int y;

  PlayPiecePayload(this.x, this.y);
}

class UpdateCapturePayload {
  int captures;
  String color;

  UpdateCapturePayload(this.color, this.captures);
}

class BoardUpdatedPayload {
  List<List> board;

  PlayPiecePayload(this.board);
}
