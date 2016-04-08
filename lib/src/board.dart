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

    void killPosition(String killColor, int x, int y) {
        this.map[x][y] = '-';
        List neighboringCoords = this.getNeighborCoords(x, y);
        for (var i =0; i < neighboringCoords.length; i++) {
            List neighbor = neighboringCoords[i];
            if (this.getColorIndicatorAt(neighbor[0], neighbor[1]) == killColor) {
                this.killPosition(killColor, neighbor[0], neighbor[1]);
            }
        }
    }

    void checkForDeath(String killerColor, int killerX, int killerY) {
        String targetColor = 'B';
        if (killerColor == 'B') {
            targetColor = 'W';
        }
         
        List neighboringCoords = this.getNeighborCoords(killerX, killerY);
        
        for (var i =0; i < neighboringCoords.length; i++) {
            List neighbor = neighboringCoords[i];
            if (this.getColorIndicatorAt(neighbor[0], neighbor[1]) == '-') {
                // already killed by another pass
                continue;
            }
            if (!this.isAlive(neighbor[0], neighbor[1], new List())) {
                this.killPosition(targetColor, neighbor[0], neighbor[1]);
            }
        }
    }

    bool isAlive(int x, int y, List checked) {
        List neighboringCoords = this.getNeighborCoords(x, y);
        
        // first see if any adjacent spot is open
        for (var i =0; i < neighboringCoords.length; i++) {
            List neighbor = neighboringCoords[i];
            if (this.getColorIndicatorAt(neighbor[0], neighbor[1]) == '-') {
                return true;
            }

        }
        List<bool> aliveNeighbors = new List();

        for (var ii =0; ii < neighboringCoords.length; ii++) {
            List neighbor = neighboringCoords[ii];
            if (checked.contains('${neighbor[0]}-${neighbor[1]}')) {
                continue;
            }
            checked.add('${neighbor[0]}-${neighbor[1]}');
            if (this.getColorIndicatorAt(neighbor[0], neighbor[1]) != this.getColorIndicatorAt(x, y)) {
                // stop checking this direction as it is enemy
                continue;
            }

            aliveNeighbors.add(this.isAlive(neighbor[0], neighbor[1], checked));
        }

        for (var j = 0; j < aliveNeighbors.length; j++) {
            if (aliveNeighbors[j] == true) {
                return true;
            }
        }

        return false;
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
        // TODO
        return true;
    }

    bool makeMove(int x, int y) {
        String color = 'B';
        if (!this.blackTurn) {
            color = 'W';
        }

        if (!this.isLegalMove(color, x, y)) {
            return false;
        }
        this.map[x][y] = color;
        this.blackTurn = !this.blackTurn;
        this.checkForDeath(color, x, y);
        return true;
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