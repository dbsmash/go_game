part of go_game;

// board configuration
var height = 500;
var width = 500;
var lines = 20;
var offset = height / lines;
var dotRadius = offset / 2 - 2;
bool blackTurn = true;

var Dot = React.registerComponent(() => new _Dot());
class _Dot extends React.Component {
  getInitialState() {
    return {
      'color': this.props['color'],
      'x': this.props['x'],
      'y': this.props['y'],
      'hover': false
    };
  }

  void onEnter(React.SyntheticMouseEvent e) {
    if (this.state['color'] != 'red') {
      return;
    }
    this.setState({'hover': true});
  }

  void onExit(React.SyntheticMouseEvent e) {
    this.setState({'hover': false});
  }

  void dotClicked(React.SyntheticMouseEvent e) {
    if (this.state['color'] == 'red') {
      String newColor = 'black';
      if (!blackTurn) {
        newColor = 'white';
      }
      this.setState({'color': newColor, 'hover': false});
      blackTurn = !blackTurn;
    } 

    this.redraw();
  }

  render() {
    double opacity = 1.0;
    String color = this.state['color'];
    if (this.state['color'] != 'black' && this.state['color'] != 'white') {
      opacity = 0.0;
    }
    if (this.state['hover'] == true) {
      color = 'black';
      if (!blackTurn) {
        color = 'white';
      }
      opacity = .5;
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

class _BoardSvg extends React.Component {

  void getDimension () {
    int avail = [window.innerHeight, window.innerWidth].reduce(min);
    avail -= 50;
    height = avail;
    width = avail;
    lines = 20;
    offset = height / lines;
    dotRadius = offset / 2 - 2;
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
      'style': {
        'opacity': '.95',
      }
    }));

    var localOffSet = 0;
    for (var i = 0; i < lines - 1; i++) {
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
      for (var ii = 0; ii < lines - 1; ii++) {
        localOffsetInterior += offset;
        dots.add(Dot({'x': localOffSet, 'y': localOffsetInterior, 'color': 'red'}));
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
