part of go_game;

var Dot = React.registerComponent(() => new _Dot());

class _Dot extends FluxComponent<Actions, GoStore> {
  getInitialState() {
    return {
      'color': this.props['color'],
      'hover': false
    };
  }

  void onEnter(React.SyntheticMouseEvent e) {
    this.setState({'hover': true});
  }

  void onExit(React.SyntheticMouseEvent e) {
    this.setState({'hover': false});
  }

  bool shouldComponentUpdate(nextProps, nextState) {
    if (nextProps['color'] != this.props['color']) {
      return true;
    }
    if (nextState['hover'] != this.state['hover']) {
      return true;
    }
    if (nextState['radius'] != this.state['radius']) {
      return true;
    }
    if (nextProps['x'] != this.props['x']) {
      return true;
    }
    if (nextProps['y'] != this.props['x']) {
      return true;
    }
    return false;
  }

  void dotClicked(React.SyntheticMouseEvent e) {
    if (this.props['color'] != '-') {
      return;
    }
    actions.requestPiecePlacement(
        new PlayPiecePayload(this.props['column'], this.props['row']));
    //this.redraw();
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
      'cx': this.props['x'],
      'cy': this.props['y'],
      'r': this.props['radius'],
      'fill': color,
      'opacity': opacity,
      'onClick': (e) => this.dotClicked(e),
      'onTouch': (e) => this.dotClicked(e),
      'onMouseEnter': (e) => this.onEnter(e),
      'onMouseLeave': (e) => this.onExit(e)
    });
  }
}
