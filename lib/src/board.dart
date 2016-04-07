part of go_game;

var BoardSvg = React.registerComponent(() => new _BoardSvg());

class _BoardSvg extends FluxComponent<Actions, GoStore> {
  getInitialState() {
    GoBoard board = new GoBoard(19);
    int avail = [window.innerHeight, window.innerWidth].reduce(min);
    avail -= 50;
    int height = avail;
    double offset = height / (board.size + 1);
    double dotRadius = offset / 2 - 2;
    
    return {
      'board': board,
      'width': height,
      'height': height,
      'lineOffset': offset,
      'dotRadius': dotRadius
    };
  }


  componentWillMount() {
    store.events.boardUpdated.listen((board) {
      this.setState({'board': board});
    });
  }

  render() {

    List children = new List();
    List dots = new List();
    int width = this.state['width'];
    int height = this.state['height'];

    // Board background
    children.add(React.rect({
      'x': 0,
      'y': 0,
      'height': height,
      'width': width,
      'fill': '#ffdc99',
      'stroke': 'darkGray',
      'strokeWidth': 2,
      'style': {'opacity': '.95',}
    }));

    var localOffSet = 0;
    for (var row = 0; row < this.state['board'].size; row++) {
      localOffSet += this.state['lineOffset'];
      children.add(React.line({
        'x1': this.state['lineOffset'],
        'y1': localOffSet,
        'x2': width - this.state['lineOffset'],
        'y2': localOffSet,
        'stroke': 'darkGray'
      }));

      children.add(React.line({
        'x1': localOffSet,
        'y1': this.state['lineOffset'],
        'x2': localOffSet,
        'y2': height - this.state['lineOffset'],
        'stroke': 'darkGray'
      }));

      var localOffsetInterior = 0;
      for (var column = 0; column < this.state['board'].size; column++) {
        localOffsetInterior += this.state['lineOffset'];

        String color = this.state['board'].getColorIndicatorAt(column, row);

        dots.add(Dot({
          'x': localOffSet,
          'y': localOffsetInterior,
          'row': row,
          'column': column,
          'color': color,
          'radius': this.state['dotRadius'],
          'actions': actions,
          'store': store
        }));
      }
    }

    children.addAll(dots);

    return React.svg({
      'version': '1.1',
      'xmlns': 'http://www.w3.org/2000/svg',
      'width': width,
      'height': height
    }, children);
  }
}
