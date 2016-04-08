part of go_game;

DispatchKey key = new DispatchKey('goGameKey');

class GoEvents {
  final Event<BoardUpdatedPayload> boardUpdated = new Event(key);
}
