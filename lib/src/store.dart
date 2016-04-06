part of go_game;

class GoStore extends Store {
    GoActions _actions;

    GoStore(this._actions) {
        _actions.playPiece.listen(_handlePlayPiece);
    }

    void _handlePlayPiece(int x) {
        print(x);
    }
}