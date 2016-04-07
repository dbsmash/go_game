part of go_game;

class GoBoard {
    List<List> map;
    bool blackTurn = true;
    int size;

    GoBoard(this.size) {
        this.map = new List<List>();
        for (var i =0; i < this.size; i++) {
            List row = new List();
            for (var ii = 0; ii< this.size; ii++) {
                row.add('-');
            }
            map.add(row);
        }
    }

    String getColorIndicatorAt(int x, int y) {
        return this.map[x][y];
    }

    List getNeighborCoords(int x, int y) {
        List neighbors = new List();

        if (x > 0) neighbors.add([x-1, y]);
        if (x < this.size - 1) neighbors.add([x + 1, y]);
        if (y > 0) neighbors.add([x, y - 1]);
        if (y < this.size - 1) neighbors.add([x, y + 1]);

        return neighbors;
    }

    bool isLegalMove(String color, int x, int y) {
        List neighbors = this.getNeighborCoords(x, y);
        for (var i =0; i < neighbors.length; i++) {
        }
        return false;
    }

    void makeMove(int x, int y) {
        String color = 'B';
        if (!this.blackTurn) {
            color = 'W';
        }
        this.map[x][y] = color;
        this.blackTurn = !this.blackTurn;
        this.getNeighborCoords(x, y);
    }

    void printBoard () {
        for (var i = 0; i < map.length; i++) {
            print(map[i]);
        }
    }

    List<List> getNeighboringSpaces(int x, int y) {
        List<List> neighboringSpaces = new List<List>();
        if (x > 0) neighboringSpaces.add()
        return neighboringSpaces;
    }
}

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
    this.board.makeMove(payload.x, payload.y);
    // handle illegal move
    blackTurn = !blackTurn;
    this.trigger();
    //_events.boardUpdated(this.board, key);
  }
}
