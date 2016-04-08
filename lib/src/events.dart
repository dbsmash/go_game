part of go_game;

DispatchKey key = new DispatchKey('goGameKey');

class GoEvents {
  final Event<BoardUpdatedPayload> boardUpdated = new Event(key);
  final Event<UpdateCapturePayload> newCapturesReported = new Event(key);
}

class ScoreEvents {
    
}
