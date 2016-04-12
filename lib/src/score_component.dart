part of go_game;

var Score = React.registerComponent(() => new _Score());

class _Score extends FluxComponent<ScoreActions, ScoreStore> {
  
  bool shouldComponentUpdate(nextProps, nextState) {
    return true;
  }

  getInitialState() {
    int avail = [window.innerHeight, window.innerWidth].reduce(min);
    int height = (avail / 5).round();
    int width = height * 3;
    
    return {
      'width': width,
      'height': height
    };
  }

  render() {
    List children = new List();

    var blackBox = ScoreBox({
      'x': 0,
      'y': 45,
      'height': this.state['height'],
      'width': this.state['width'],
      'actions': this.actions, 
      'store': this.store,
      'color': 'black',
      'fill': '#ffdc99',
      'stroke': 'darkGray',
      'strokeWidth': 1,
      'style': {'opacity': '.95',}
    });

    var whiteBox = ScoreBox({
      'x': 0,
      'y': 245,
      'height': this.state['height'],
      'width': this.state['width'],
      'actions': this.actions, 
      'store': this.store,
      'color': 'white',
      'fill': '#ffdc99',
      'stroke': 'darkGray',
      'strokeWidth': 1,
      'style': {'opacity': '.95',}
    });

    children.add(blackBox);
    children.add(whiteBox);

    return React.svg({
      'version': '1.1',
      'xmlns': 'http://www.w3.org/2000/svg',
      'width': this.state['width'],
      'height': this.state['height'] * 5
    }, children);
  }
}
