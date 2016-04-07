part of go_game;

// board configuration
var height = 500;
var width = 500;
var lines = 20;
var offset = height / lines;
var dotRadius = offset / 2 - 2;

var Dot = React.registerComponent(() => new _Dot());

class _Dot extends FluxComponent<Actions, GoStore> {
  getInitialState() {
    return {
      'color': this.props['color'],
      'x': this.props['x'],
      'y': this.props['y'],
      'row': this.props['row'],
      'column': this.props['column'],
      'hover': false
    };
  }

  void onEnter(React.SyntheticMouseEvent e) {
    this.setState({'hover': true});
  }

  void onExit(React.SyntheticMouseEvent e) {
    this.setState({'hover': false});
  }

  shouldComponentUpdate(nextProps, nextState) {
    if (nextProps['color'] != this.props['color']) {
      return true;
    }
    if (nextState['hover'] != this.state['hover']) {
      return true;
    }
    return false;
  }

  void dotClicked(React.SyntheticMouseEvent e) {
    if (this.props['color'] != '-') {
      return;
    }
    actions.requestPiecePlacement(
        new PlayPiecePayload(this.state['column'], this.state['row']));
    this.redraw();
  }

  render() {
    double opacity = 1.0;
    String color = this.props['color'];
    if (color == '-') {
      color = 'red';
      opacity = 0.0;
      if (this.state['hover'] == true) {
        color = store.getHoverColor();
        opacity = .5;
      }
    } else if (color == 'W') {
      color = 'white';
    } else if (color == 'B') {
      color = 'black';
    }

    return React.circle({
      'cx': this.state['x'],
      'cy': this.state['y'],
      'r': dotRadius,
      'fill': color,
      'opacity': opacity,
      'onClick': (e) => this.dotClicked(e),
      'onTouch': (e) => this.dotClicked(e),
      'onMouseEnter': (e) => this.onEnter(e),
      'onMouseLeave': (e) => this.onExit(e)
    });
  }
}

var BoardSvg = React.registerComponent(() => new _BoardSvg());

class _BoardSvg extends FluxComponent<Actions, GoStore> {
  getInitialState() {
    return {'board': new GoBoard(19)};
  }

  void getDimension() {
    int avail = [window.innerHeight, window.innerWidth].reduce(min);
    avail -= 50;
    height = avail;
    width = avail;
    lines = 20;
    offset = height / lines;
    dotRadius = offset / 2 - 2;
  }

  componentWillMount() {
    store.events.boardUpdated.listen((board) {
      this.setState({'board': board});
    });
  }

  render() {
    this.getDimension();

    List children = new List();
    List dots = new List();
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
    for (var i = 0; i < this.state['board'].size; i++) {
      localOffSet += offset;
      children.add(React.line({
        'x1': offset,
        'y1': localOffSet,
        'x2': width - offset,
        'y2': localOffSet,
        'stroke': 'darkGray'
      }));

      children.add(React.line({
        'x1': localOffSet,
        'y1': offset,
        'x2': localOffSet,
        'y2': height - offset,
        'stroke': 'darkGray'
      }));

      var localOffsetInterior = 0;
      for (var ii = 0; ii < this.state['board'].size; ii++) {
        localOffsetInterior += offset;

        String color = this.state['board'].getColorIndicatorAt(ii, i);

        dots.add(Dot({
          'x': localOffSet,
          'y': localOffsetInterior,
          'row': i,
          'column': ii,
          'color': color,
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
      'height': height,
      'style': {
        'WebkitTouchCallout': 'none',
        'WebkitUserSelect': 'none',
        'KhtmlUserSelect': 'none',
        'MozUserSelect': 'none',
        'MsUserSelect': 'none',
        'userSelect': 'none',
        // 'transform': 'scale(3.0)',
        // 'outline': '1px solid rgba(200, 200, 200, .75)',
      }
    }, children);
  }
}
