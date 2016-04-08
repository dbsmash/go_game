part of go_game;

class GoActions {
  Action<PlayPiecePayload> requestPiecePlacement =
      new Action<PlayPiecePayload>();
}

class ScoreActions {
  Action<UpdateCapturePayload> requestCaptureRecord =
      new Action<UpdateCapturePayload>();
}
