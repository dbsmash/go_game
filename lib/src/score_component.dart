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
    int blackCaptures = store.blackCaptured;
    int whiteCaptures = store.whiteCaptured;
    var blackRect = React.rect({
      'x': 0,
      'y': 10,
      'height': this.state['height'],
      'width': this.state['width'],
      'fill': '#ffdc99',
      'stroke': 'darkGray',
      'strokeWidth': 1,
      'style': {'opacity': '.95',}
    });

    var whiteRect = React.rect({
      'x': 0,
      'y': (10 + this.state['height'] + 20),
      'height': this.state['height'],
      'width': this.state['width'],
      'fill': '#ffdc99',
      'stroke': 'darkGray',
      'strokeWidth': 1,
      'style': {'opacity': '.95',}
    });

    children.add(blackRect);
    children.add(whiteRect);

    children.add(React.text({
      'x': 30,
      'y': 10 + (this.state['height'] / 2).round(),
      'height': 100,
      'width': 300,
      'fontSize': 24
      }, '${blackCaptures} black stones captured'));

    children.add(React.text({
      'x': 30,
      'y': 10 + this.state['height'] + (this.state['height'] / 2).round() + 20,
      'height': 100,
      'width': this.state['width'],
      'fontSize': 24
      }, '${whiteCaptures} white stones captured'));

    return React.svg({
      'version': '1.1',
      'xmlns': 'http://www.w3.org/2000/svg',
      'width': this.state['width'],
      'height': this.state['height'] * 5
    }, children);
  }
}
